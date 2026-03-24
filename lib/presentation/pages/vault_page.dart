import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zk_password/domain/entities/vault_item.dart';
import 'package:zk_password/presentation/providers/app_providers.dart';
import 'package:zk_password/presentation/widgets/ambient_background.dart';
import 'package:zk_password/presentation/widgets/glass_panel.dart';

class VaultPage extends ConsumerStatefulWidget {
  const VaultPage({super.key});

  @override
  ConsumerState<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends ConsumerState<VaultPage> {
  final _searchController = TextEditingController();
  Timer? _clipboardTimer;
  String? _lastCopiedValue;

  @override
  void dispose() {
    _searchController.dispose();
    _clipboardTimer?.cancel();
    super.dispose();
  }

  Future<void> _copyPassword(String password) async {
    await Clipboard.setData(ClipboardData(text: password));
    _lastCopiedValue = password;

    _clipboardTimer?.cancel();
    _clipboardTimer = Timer(const Duration(seconds: 30), () async {
      final clipboard = await Clipboard.getData('text/plain');
      if (clipboard?.text == _lastCopiedValue) {
        await Clipboard.setData(const ClipboardData(text: ''));
      }
      _lastCopiedValue = null;
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password copied. Clipboard clears in 30s.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionControllerProvider);
    final vault = ref.watch(vaultControllerProvider);
    final cloudAuth = ref.watch(cloudAuthControllerProvider);
    final syncService = ref.watch(syncServiceProvider);
    final sessionController = ref.read(sessionControllerProvider.notifier);
    final vaultController = ref.read(vaultControllerProvider.notifier);
    final cloudAuthController = ref.read(cloudAuthControllerProvider.notifier);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: sessionController.touch,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push('/entry/new'),
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: const Color(0xFF0D1116),
          label: const Text('Add entry'),
          icon: const Icon(Icons.add),
        ),
        body: AmbientBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                children: [
                  GlassPanel(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Encrypted Vault',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme.colorScheme.primary,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'A command center for modern credentials.',
                                    style: theme.textTheme.displaySmall,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Search, sync, and inspect entries without ever exposing the plaintext outside the local session.',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.72,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                _ActionCircle(
                                  icon: Icons.sync,
                                  tooltip: 'Sync',
                                  onTap:
                                      session.keyBytes == null ||
                                          !syncService.isEnabled ||
                                          !cloudAuth.isSignedIn
                                      ? null
                                      : () async {
                                          final messenger =
                                              ScaffoldMessenger.of(context);
                                          sessionController.touch();
                                          await vaultController.sync(
                                            session.keyBytes!,
                                          );
                                          if (!mounted) {
                                            return;
                                          }
                                          final updatedState = ref.read(
                                            vaultControllerProvider,
                                          );
                                          if (updatedState.message == null) {
                                            return;
                                          }
                                          messenger.showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                updatedState.message!,
                                              ),
                                            ),
                                          );
                                        },
                                ),
                                if (cloudAuth.isConfigured)
                                  _ActionCircle(
                                    icon: cloudAuth.isSignedIn
                                        ? Icons.cloud_done
                                        : Icons.cloud_off,
                                    tooltip: cloudAuth.isSignedIn
                                        ? 'Disconnect cloud sync'
                                        : 'Cloud sync not connected',
                                    onTap: cloudAuth.isLoading
                                        ? null
                                        : cloudAuthController.signOut,
                                  ),
                                _ActionCircle(
                                  icon: Icons.lock_clock,
                                  tooltip: 'Lock',
                                  onTap: sessionController.lock,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 14,
                          runSpacing: 14,
                          children: [
                            _MetricCard(
                              label: 'Entries',
                              value: '${vault.items.length}',
                              accent: const Color(0xFF39D0BC),
                            ),
                            _MetricCard(
                              label: 'Favorites',
                              value:
                                  '${vault.items.where((item) => item.isFavorite).length}',
                              accent: const Color(0xFFE4B77A),
                            ),
                            _MetricCard(
                              label: 'Sync',
                              value: !syncService.isEnabled
                                  ? 'Local'
                                  : cloudAuth.isSignedIn
                                  ? 'Live'
                                  : 'Ready',
                              accent: const Color(0xFF8AB4FF),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (cloudAuth.isConfigured)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _CloudSyncBanner(
                        isSignedIn: cloudAuth.isSignedIn,
                        email: cloudAuth.user?.email,
                        isSyncEnabled: syncService.isEnabled,
                      ),
                    ),
                  GlassPanel(
                    padding: const EdgeInsets.all(18),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        vaultController.setQuery(value);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Search by title, username, category, or URL',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  vaultController.setQuery('');
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: vault.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : vault.filteredItems.isEmpty
                        ? _EmptyVaultState(
                            hasItems: vault.items.isNotEmpty,
                            onCreateEntry: () => context.push('/entry/new'),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: vault.filteredItems.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 14),
                            itemBuilder: (context, index) {
                              final item = vault.filteredItems[index];
                              return _VaultCard(
                                item: item,
                                onTap: () => context.push(
                                  '/entry/${item.id}',
                                  extra: item,
                                ),
                                onCopy: () => _copyPassword(item.password),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CloudSyncBanner extends StatelessWidget {
  const _CloudSyncBanner({
    required this.isSignedIn,
    required this.email,
    required this.isSyncEnabled,
  });

  final bool isSignedIn;
  final String? email;
  final bool isSyncEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = isSignedIn
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Icon(isSignedIn ? Icons.cloud_done : Icons.cloud_off),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              !isSyncEnabled
                  ? 'Supabase is not configured for this build.'
                  : isSignedIn
                  ? 'Encrypted sync connected as ${email ?? 'current user'}.'
                  : 'Cloud sync is available, but no Supabase user is signed in.',
            ),
          ),
        ],
      ),
    );
  }
}

class _VaultCard extends StatelessWidget {
  const _VaultCard({
    required this.item,
    required this.onTap,
    required this.onCopy,
  });

  final VaultItem item;
  final VoidCallback onTap;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassPanel(
      padding: const EdgeInsets.all(0),
      radius: 26,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 18,
        ),
        title: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF39D0BC),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF39D0BC).withValues(alpha: 0.34),
                    blurRadius: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if ((item.category ?? '').isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: theme.colorScheme.secondaryContainer,
                ),
                child: Text(
                  item.category!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.username,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.82),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black.withValues(alpha: 0.18),
                ),
                child: Row(
                  children: [
                    Text(
                      'Password',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.55),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '••••••••••••',
                      style: theme.textTheme.titleMedium?.copyWith(
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              onPressed: onCopy,
              icon: const Icon(Icons.copy_all_outlined),
              tooltip: 'Copy password',
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _EmptyVaultState extends StatelessWidget {
  const _EmptyVaultState({required this.hasItems, required this.onCreateEntry});

  final bool hasItems;
  final VoidCallback onCreateEntry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 44),
            const SizedBox(height: 16),
            Text(
              hasItems ? 'No matching entries' : 'Your vault is empty',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              hasItems
                  ? 'Try a different search query.'
                  : 'Create your first encrypted credential entry.',
              textAlign: TextAlign.center,
            ),
            if (!hasItems) ...[
              const SizedBox(height: 18),
              FilledButton(
                onPressed: onCreateEntry,
                child: const Text('Create first entry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.18),
            Colors.white.withValues(alpha: 0.03),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.64),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.headlineSmall),
        ],
      ),
    );
  }
}

class _ActionCircle extends StatelessWidget {
  const _ActionCircle({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withValues(alpha: 0.06),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Icon(icon),
        ),
      ),
    );
  }
}
