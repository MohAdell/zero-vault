import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zk_password/presentation/providers/app_providers.dart';
import 'package:zk_password/presentation/providers/cloud_auth_controller.dart';
import 'package:zk_password/presentation/widgets/ambient_background.dart';
import 'package:zk_password/presentation/widgets/feature_pill.dart';
import 'package:zk_password/presentation/widgets/glass_panel.dart';

class UnlockPage extends ConsumerStatefulWidget {
  const UnlockPage({super.key});

  @override
  ConsumerState<UnlockPage> createState() => _UnlockPageState();
}

class _UnlockPageState extends ConsumerState<UnlockPage> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _cloudPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureCloudPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _cloudPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final success = await ref
        .read(sessionControllerProvider.notifier)
        .unlock(_passwordController.text);

    if (success) {
      _passwordController.clear();
    }
  }

  Future<void> _signInCloud() async {
    await ref
        .read(cloudAuthControllerProvider.notifier)
        .signIn(
          email: _emailController.text.trim(),
          password: _cloudPasswordController.text,
        );
  }

  Future<void> _signUpCloud() async {
    await ref
        .read(cloudAuthControllerProvider.notifier)
        .signUp(
          email: _emailController.text.trim(),
          password: _cloudPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final session = ref.watch(sessionControllerProvider);
    final cloudAuth = ref.watch(cloudAuthControllerProvider);
    final isDesktop = MediaQuery.sizeOf(context).width >= 1100;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AmbientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1320),
                child: Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: isDesktop ? 11 : 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: isDesktop ? 24 : 0,
                          bottom: isDesktop ? 0 : 24,
                        ),
                        child: _UnlockHero(
                          sessionNeedsSetup: session.needsSetup,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isDesktop ? 460 : double.infinity,
                      child: GlassPanel(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Private Command Layer',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.secondary,
                                letterSpacing: 1.8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              session.needsSetup
                                  ? 'Create the vault key'
                                  : 'Resume your vault',
                              style: theme.textTheme.displaySmall,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              session.needsSetup
                                  ? 'One passphrase unlocks local encryption, secure storage, and optional cloud sync.'
                                  : 'Your master password never reaches the server. The encrypted snapshot stays unreadable outside this device.',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withValues(alpha: 0.76),
                              ),
                            ),
                            const SizedBox(height: 28),
                            if (!session.initialized)
                              const Center(child: CircularProgressIndicator())
                            else ...[
                              TextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                onSubmitted: (_) => _submit(),
                                decoration: InputDecoration(
                                  labelText: 'Master password',
                                  hintText: session.needsSetup
                                      ? 'Choose a strong passphrase'
                                      : 'Enter your master password',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                              ),
                              if (session.errorMessage != null) ...[
                                const SizedBox(height: 12),
                                Text(
                                  session.errorMessage!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.error,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 18),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  onPressed: session.isBusy ? null : _submit,
                                  child: Text(
                                    session.needsSetup
                                        ? 'Create vault'
                                        : 'Unlock vault',
                                  ),
                                ),
                              ),
                              if (cloudAuth.isConfigured) ...[
                                const SizedBox(height: 28),
                                Container(
                                  height: 1,
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                                const SizedBox(height: 24),
                                _CloudSection(
                                  cloudAuth: cloudAuth,
                                  emailController: _emailController,
                                  cloudPasswordController:
                                      _cloudPasswordController,
                                  obscureCloudPassword: _obscureCloudPassword,
                                  onTogglePassword: () {
                                    setState(() {
                                      _obscureCloudPassword =
                                          !_obscureCloudPassword;
                                    });
                                  },
                                  onSignIn: _signInCloud,
                                  onSignUp: _signUpCloud,
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UnlockHero extends StatelessWidget {
  const _UnlockHero({required this.sessionNeedsSetup});

  final bool sessionNeedsSetup;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ZK Password',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
            letterSpacing: 2.8,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          sessionNeedsSetup
              ? 'A modern vault where the secret key never leaves your device.'
              : 'Elegant password security with zero-knowledge at the center.',
          style: theme.textTheme.displayLarge?.copyWith(height: 0.94),
        ),
        const SizedBox(height: 20),
        Text(
          'Argon2id derives the key locally. AES-256-GCM encrypts every field. Biometrics protect the live session. Supabase receives only opaque ciphertext blobs.',
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.74),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        const Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FeaturePill(label: 'Argon2id 64 MB', icon: Icons.memory),
            FeaturePill(label: 'AES-256-GCM', icon: Icons.enhanced_encryption),
            FeaturePill(label: 'Biometric resume', icon: Icons.fingerprint),
            FeaturePill(label: 'Encrypted cloud sync', icon: Icons.cloud_done),
          ],
        ),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 760;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _SignalCard(
                  width: compact ? constraints.maxWidth : 220,
                  kicker: 'Local First',
                  title: 'Session key wiped on lock',
                  body:
                      'The live key remains in memory only during an active session.',
                ),
                _SignalCard(
                  width: compact ? constraints.maxWidth : 220,
                  kicker: 'Cloud Optional',
                  title: 'Encrypted snapshots only',
                  body: 'Readable vault data never leaves the device boundary.',
                ),
                _SignalCard(
                  width: compact ? constraints.maxWidth : 220,
                  kicker: 'Fast Recovery',
                  title: 'Biometric re-entry',
                  body:
                      'Resume the active session on return without exposing plaintext.',
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SignalCard extends StatelessWidget {
  const _SignalCard({
    required this.width,
    required this.kicker,
    required this.title,
    required this.body,
  });

  final double width;
  final String kicker;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: GlassPanel(
        padding: const EdgeInsets.all(18),
        radius: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kicker,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.secondary,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(title, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(
              body,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CloudSection extends StatelessWidget {
  const _CloudSection({
    required this.cloudAuth,
    required this.emailController,
    required this.cloudPasswordController,
    required this.obscureCloudPassword,
    required this.onTogglePassword,
    required this.onSignIn,
    required this.onSignUp,
  });

  final CloudAuthState cloudAuth;
  final TextEditingController emailController;
  final TextEditingController cloudPasswordController;
  final bool obscureCloudPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Encrypted cloud sync', style: theme.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          cloudAuth.isSignedIn
              ? 'Connected as ${cloudAuth.user?.email ?? cloudAuth.user?.id}.'
              : 'Optional. Connect Supabase to sync only encrypted snapshots.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.72),
          ),
        ),
        if (!cloudAuth.isSignedIn) ...[
          const SizedBox(height: 18),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: cloudPasswordController,
            obscureText: obscureCloudPassword,
            decoration: InputDecoration(
              labelText: 'Cloud password',
              suffixIcon: IconButton(
                onPressed: onTogglePassword,
                icon: Icon(
                  obscureCloudPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: cloudAuth.isLoading ? null : onSignUp,
                  child: const Text('Create account'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: cloudAuth.isLoading ? null : onSignIn,
                  child: Text(cloudAuth.isLoading ? 'Working...' : 'Sign in'),
                ),
              ),
            ],
          ),
        ],
        if (cloudAuth.message != null) ...[
          const SizedBox(height: 12),
          Text(
            cloudAuth.message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cloudAuth.isSignedIn
                  ? theme.colorScheme.primary
                  : theme.colorScheme.error,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}
