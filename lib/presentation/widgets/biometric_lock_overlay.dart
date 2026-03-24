import 'package:flutter/material.dart';
import 'package:zk_password/presentation/widgets/glass_panel.dart';

class BiometricLockOverlay extends StatelessWidget {
  const BiometricLockOverlay({
    super.key,
    required this.isBusy,
    this.errorMessage,
    required this.onRetry,
    required this.onLockNow,
  });

  final bool isBusy;
  final String? errorMessage;
  final VoidCallback onRetry;
  final VoidCallback onLockNow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: const Color(0xFF02080B).withValues(alpha: 0.82),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: GlassPanel(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.fingerprint,
                  size: 42,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Session protected',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Authenticate with biometrics to resume the active in-memory session.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.82),
                  ),
                ),
                if (errorMessage != null) ...[
                  const SizedBox(height: 14),
                  Text(
                    errorMessage!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: isBusy ? null : onRetry,
                        icon: isBusy
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.verified_user),
                        label: Text(
                          isBusy ? 'Checking...' : 'Unlock with biometrics',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: isBusy ? null : onLockNow,
                  child: const Text('Lock now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
