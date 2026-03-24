import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zk_password/core/config/app_config.dart';
import 'package:zk_password/data/local/local_vault_database.dart';
import 'package:zk_password/data/repositories/vault_repo.dart';
import 'package:zk_password/data/repositories/vault_repo_impl.dart';
import 'package:zk_password/presentation/providers/app_providers.dart';
import 'package:zk_password/presentation/widgets/biometric_lock_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appConfig = AppConfig.fromEnvironment();
  if (appConfig.hasSupabase) {
    await Supabase.initialize(
      url: appConfig.supabaseUrl,
      anonKey: appConfig.supabaseKey,
    );
  }
  final vaultRepo = await _bootstrapVaultRepo();

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(appConfig),
        vaultRepoProvider.overrideWithValue(vaultRepo),
      ],
      child: const ZkPasswordApp(),
    ),
  );
}

Future<VaultRepo> _bootstrapVaultRepo() async {
  try {
    final isar = await LocalVaultDatabase.open();
    return VaultRepoImpl(isar);
  } catch (_) {
    return VaultRepoImpl.inMemory();
  }
}

class ZkPasswordApp extends ConsumerStatefulWidget {
  const ZkPasswordApp({super.key});

  @override
  ConsumerState<ZkPasswordApp> createState() => _ZkPasswordAppState();
}

class _ZkPasswordAppState extends ConsumerState<ZkPasswordApp> {
  late final AppLifecycleListener _appLifecycleListener;

  @override
  void initState() {
    super.initState();
    _appLifecycleListener = AppLifecycleListener(
      onPause: _handleBackgrounded,
      onHide: _handleBackgrounded,
      onDetach: _handleBackgrounded,
      onResume: _handleResumed,
    );
  }

  void _handleBackgrounded() {
    ref.read(sessionControllerProvider.notifier).markBackgrounded();
  }

  void _handleResumed() {
    unawaited(
      ref.read(sessionControllerProvider.notifier).reauthenticateSession(),
    );
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(sessionLifecycleProvider);
    final router = ref.watch(routerProvider);
    final session = ref.watch(sessionControllerProvider);
    final sessionController = ref.read(sessionControllerProvider.notifier);

    return MaterialApp.router(
      title: 'ZK Password',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      builder: (context, child) {
        final content = child ?? const SizedBox.shrink();
        return Listener(
          onPointerDown: (_) => sessionController.touch(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              content,
              if (session.requiresBiometricReentry)
                BiometricLockOverlay(
                  isBusy: session.isBusy,
                  errorMessage: session.errorMessage,
                  onRetry: () {
                    unawaited(sessionController.reauthenticateSession());
                  },
                  onLockNow: sessionController.lock,
                ),
            ],
          ),
        );
      },
      routerConfig: router,
    );
  }

  ThemeData _buildTheme() {
    const primary = Color(0xFF39D0BC);
    const secondary = Color(0xFFE4B77A);
    const background = Color(0xFF07131A);
    const surface = Color(0xFF10252D);
    const onSurface = Color(0xFFF4F1EA);
    const outline = Color(0xFF2B4D55);

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: Color(0xFF031012),
        secondary: secondary,
        onSecondary: Color(0xFF1A1207),
        error: Color(0xFFFF8A80),
        onError: Colors.black,
        surface: surface,
        onSurface: onSurface,
        primaryContainer: Color(0xFF153841),
        onPrimaryContainer: Color(0xFFD7FFF8),
        secondaryContainer: Color(0xFF43321A),
        onSecondaryContainer: Color(0xFFFFE8C8),
        outline: outline,
        outlineVariant: Color(0xFF1B3942),
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: Color(0xFFEFE8DD),
        onInverseSurface: Color(0xFF10181B),
        inversePrimary: Color(0xFF006B62),
        surfaceContainerHighest: Color(0xFF16323B),
      ),
      scaffoldBackgroundColor: background,
    );

    final display = GoogleFonts.cormorantGaramondTextTheme(base.textTheme);
    final body = GoogleFonts.outfitTextTheme(
      display,
    ).apply(bodyColor: onSurface, displayColor: onSurface);

    return base.copyWith(
      textTheme: body.copyWith(
        displayLarge: body.displayLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -1.3,
        ),
        displayMedium: body.displayMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
        ),
        headlineLarge: body.headlineLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        headlineMedium: body.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        titleLarge: body.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        titleMedium: body.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(22)),
          borderSide: BorderSide(color: primary, width: 1.3),
        ),
        hintStyle: TextStyle(color: onSurface.withValues(alpha: 0.48)),
        labelStyle: TextStyle(color: onSurface.withValues(alpha: 0.74)),
      ),
      cardTheme: CardThemeData(
        color: surface.withValues(alpha: 0.72),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF041114),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
          foregroundColor: onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF10252D),
        contentTextStyle: const TextStyle(color: onSurface),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
