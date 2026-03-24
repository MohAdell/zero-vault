import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zk_password/domain/entities/vault_item.dart';
import 'package:zk_password/presentation/providers/app_providers.dart';
import 'package:zk_password/presentation/widgets/ambient_background.dart';
import 'package:zk_password/presentation/widgets/glass_panel.dart';

class EntryDetailPage extends ConsumerStatefulWidget {
  const EntryDetailPage({super.key, this.item});

  final VaultItem? item;

  @override
  ConsumerState<EntryDetailPage> createState() => _EntryDetailPageState();
}

class _EntryDetailPageState extends ConsumerState<EntryDetailPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _urlController;
  late final TextEditingController _categoryController;
  late final TextEditingController _notesController;
  bool _isSaving = false;
  bool _isCheckingBreach = false;
  String? _breachMessage;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _titleController = TextEditingController(text: item?.title ?? '');
    _usernameController = TextEditingController(text: item?.username ?? '');
    _passwordController = TextEditingController(text: item?.password ?? '');
    _urlController = TextEditingController(text: item?.url ?? '');
    _categoryController = TextEditingController(text: item?.category ?? '');
    _notesController = TextEditingController(text: item?.notes ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _urlController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final session = ref.read(sessionControllerProvider);
    if (session.keyBytes == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session locked. Unlock again first.')),
        );
      }
      return;
    }

    if (_titleController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and password are required.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final now = DateTime.now();
    final existing = widget.item;
    final item = VaultItem(
      id: existing?.id ?? ref.read(uuidProvider).v4(),
      title: _titleController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text,
      url: _urlController.text.trim().isEmpty
          ? null
          : _urlController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      category: _categoryController.text.trim().isEmpty
          ? null
          : _categoryController.text.trim(),
      totpSecret: existing?.totpSecret,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
      isFavorite: existing?.isFavorite ?? false,
    );

    await ref
        .read(vaultControllerProvider.notifier)
        .saveItem(item: item, keyBytes: session.keyBytes!);

    if (!mounted) {
      return;
    }

    setState(() {
      _isSaving = false;
    });
    context.go('/vault');
  }

  void _generatePassword() {
    final password = ref.read(passwordGeneratorProvider).generate();
    setState(() {
      _passwordController.text = password;
      _breachMessage = null;
    });
  }

  Future<void> _checkBreach() async {
    if (_passwordController.text.isEmpty) {
      return;
    }

    setState(() {
      _isCheckingBreach = true;
      _breachMessage = null;
    });

    try {
      final result = await ref
          .read(breachCheckerProvider)
          .checkPassword(_passwordController.text);
      setState(() {
        _breachMessage = result.isPwned
            ? 'This password appears in ${result.breachCount} known breaches.'
            : 'No breach match found via k-anonymity lookup.';
      });
    } catch (_) {
      setState(() {
        _breachMessage = 'Breach check unavailable right now.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingBreach = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final entropy = ref
        .watch(passwordGeneratorProvider)
        .estimateEntropy(_passwordController.text);
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.sizeOf(context).width > 960;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AmbientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              GlassPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/vault'),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item == null
                                    ? 'Compose a new secure entry'
                                    : 'Refine an existing secure entry',
                                style: theme.textTheme.displaySmall,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Every sensitive field is encrypted before it reaches storage or sync.',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.72),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        _EntropyBadge(entropy: entropy),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _FieldGroup(
                        label: 'Credential',
                        children: [
                          TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username / email',
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _passwordController,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: Wrap(
                                spacing: 4,
                                children: [
                                  IconButton(
                                    onPressed: _generatePassword,
                                    icon: const Icon(Icons.auto_fix_high),
                                    tooltip: 'Generate',
                                  ),
                                  IconButton(
                                    onPressed: _isCheckingBreach
                                        ? null
                                        : _checkBreach,
                                    icon: _isCheckingBreach
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Icon(Icons.shield_outlined),
                                    tooltip: 'Check breaches',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (_breachMessage != null) ...[
                            const SizedBox(height: 10),
                            Text(
                              _breachMessage!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: _breachMessage!.startsWith('This')
                                    ? theme.colorScheme.error
                                    : theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _FieldGroup(
                        label: 'Metadata',
                        children: [
                          TextField(
                            controller: _urlController,
                            decoration: const InputDecoration(labelText: 'URL'),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _categoryController,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _notesController,
                            minLines: 8,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              labelText: 'Notes',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else ...[
                _FieldGroup(
                  label: 'Credential',
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username / email',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Wrap(
                          spacing: 4,
                          children: [
                            IconButton(
                              onPressed: _generatePassword,
                              icon: const Icon(Icons.auto_fix_high),
                              tooltip: 'Generate',
                            ),
                            IconButton(
                              onPressed: _isCheckingBreach
                                  ? null
                                  : _checkBreach,
                              icon: _isCheckingBreach
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.shield_outlined),
                              tooltip: 'Check breaches',
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_breachMessage != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        _breachMessage!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _breachMessage!.startsWith('This')
                              ? theme.colorScheme.error
                              : theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                _FieldGroup(
                  label: 'Metadata',
                  children: [
                    TextField(
                      controller: _urlController,
                      decoration: const InputDecoration(labelText: 'URL'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _categoryController,
                      decoration: const InputDecoration(labelText: 'Category'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _notesController,
                      minLines: 4,
                      maxLines: 6,
                      decoration: const InputDecoration(labelText: 'Notes'),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 18),
              FilledButton(
                onPressed: _isSaving ? null : _save,
                child: Text(_isSaving ? 'Saving...' : 'Save entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldGroup extends StatelessWidget {
  const _FieldGroup({required this.label, required this.children});

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _EntropyBadge extends StatelessWidget {
  const _EntropyBadge({required this.entropy});

  final double entropy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strength = entropy >= 80
        ? 'Elite'
        : entropy >= 60
        ? 'Strong'
        : entropy >= 40
        ? 'Moderate'
        : 'Weak';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.22),
            theme.colorScheme.secondary.withValues(alpha: 0.14),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strength,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text('${entropy.toStringAsFixed(1)} bits'),
        ],
      ),
    );
  }
}
