import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:zk_password/core/auth/auth_service.dart';
import 'package:zk_password/core/config/app_config.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';
import 'package:zk_password/core/utils/breach_checker.dart';
import 'package:zk_password/core/utils/password_generator.dart';
import 'package:zk_password/data/auth/supabase_auth_service.dart';
import 'package:zk_password/data/models/vault_entry_codec.dart';
import 'package:zk_password/data/repositories/vault_repo.dart';
import 'package:zk_password/data/repositories/vault_repo_impl.dart';
import 'package:zk_password/data/sync/sync_service.dart';
import 'package:zk_password/domain/entities/vault_item.dart';
import 'package:zk_password/domain/usecases/add_entry.dart';
import 'package:zk_password/domain/usecases/sync_vault.dart';
import 'package:zk_password/domain/usecases/unlock_vault.dart';
import 'package:zk_password/presentation/pages/entry_detail_page.dart';
import 'package:zk_password/presentation/pages/unlock_page.dart';
import 'package:zk_password/presentation/pages/vault_page.dart';
import 'package:zk_password/presentation/providers/cloud_auth_controller.dart';
import 'package:zk_password/presentation/providers/session_controller.dart';
import 'package:zk_password/presentation/providers/vault_controller.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
});

final cryptoServiceProvider = Provider<CryptoService>((ref) => CryptoService());
final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final passwordGeneratorProvider = Provider<PasswordGenerator>(
  (ref) => PasswordGenerator(),
);
final breachCheckerProvider = Provider<BreachChecker>((ref) {
  final checker = BreachChecker();
  ref.onDispose(checker.dispose);
  return checker;
});
final uuidProvider = Provider<Uuid>((ref) => const Uuid());
final supabaseClientProvider = Provider<SupabaseClient?>((ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.hasSupabase) {
    return null;
  }

  return Supabase.instance.client;
});
final cloudAuthServiceProvider = Provider<SupabaseAuthService>((ref) {
  return SupabaseAuthService(ref.watch(supabaseClientProvider));
});
final cloudAuthControllerProvider =
    StateNotifierProvider<CloudAuthController, CloudAuthState>((ref) {
      return CloudAuthController(ref.watch(cloudAuthServiceProvider));
    });

final vaultRepoProvider = Provider<VaultRepo>(
  (ref) => VaultRepoImpl.inMemory(),
);
final vaultEntryCodecProvider = Provider<VaultEntryCodec>((ref) {
  return VaultEntryCodec(ref.watch(cryptoServiceProvider));
});

final unlockVaultProvider = Provider<UnlockVault>((ref) {
  return UnlockVault(
    cryptoService: ref.watch(cryptoServiceProvider),
    secureStorage: ref.watch(secureStorageProvider),
  );
});

final addEntryProvider = Provider<AddEntry>((ref) {
  return AddEntry(
    vaultRepo: ref.watch(vaultRepoProvider),
    entryCodec: ref.watch(vaultEntryCodecProvider),
  );
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    cryptoService: ref.watch(cryptoServiceProvider),
    client: ref.watch(supabaseClientProvider),
    tableName: ref.watch(appConfigProvider).vaultSnapshotsTable,
  );
});

final syncVaultProvider = Provider<SyncVault>((ref) {
  return SyncVault(ref.watch(syncServiceProvider));
});

final sessionControllerProvider =
    StateNotifierProvider<SessionController, SessionState>((ref) {
      return SessionController(
        unlockVault: ref.watch(unlockVaultProvider),
        authService: ref.watch(authServiceProvider),
        cryptoService: ref.watch(cryptoServiceProvider),
      );
    });

final vaultControllerProvider =
    StateNotifierProvider<VaultController, VaultState>((ref) {
      return VaultController(
        vaultRepo: ref.watch(vaultRepoProvider),
        entryCodec: ref.watch(vaultEntryCodecProvider),
        addEntry: ref.watch(addEntryProvider),
        syncVault: ref.watch(syncVaultProvider),
      );
    });

final sessionLifecycleProvider = Provider<void>((ref) {
  ref.listen<SessionState>(sessionControllerProvider, (previous, next) {
    if (previous?.isUnlocked == true && !next.isUnlocked) {
      ref.read(vaultControllerProvider.notifier).clear();
    }

    if (next.isUnlocked && next.keyBytes != null) {
      unawaited(
        ref.read(vaultControllerProvider.notifier).load(next.keyBytes!),
      );
    }
  });
});

class _RouterRefreshListenable extends ChangeNotifier {
  void ping() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshListenable = _RouterRefreshListenable();
  ref.onDispose(refreshListenable.dispose);
  ref.listen<SessionState>(
    sessionControllerProvider,
    (_, __) => refreshListenable.ping(),
  );

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final session = ref.read(sessionControllerProvider);
      final onUnlockPage = state.matchedLocation == '/';

      if (!session.initialized) {
        return onUnlockPage ? null : '/';
      }

      if (!session.isUnlocked && !onUnlockPage) {
        return '/';
      }

      if (session.isUnlocked && onUnlockPage) {
        return '/vault';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const UnlockPage()),
      GoRoute(path: '/vault', builder: (context, state) => const VaultPage()),
      GoRoute(
        path: '/entry/new',
        builder: (context, state) => const EntryDetailPage(),
      ),
      GoRoute(
        path: '/entry/:id',
        builder: (context, state) {
          final item = state.extra as VaultItem?;
          return EntryDetailPage(item: item);
        },
      ),
    ],
  );
});
