import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  AuthService({
    LocalAuthentication? localAuthentication,
    this.lockTimeout = const Duration(minutes: 2),
  }) : _localAuthentication = localAuthentication ?? LocalAuthentication();

  final LocalAuthentication _localAuthentication;
  final Duration lockTimeout;

  Timer? _lockTimer;

  Future<bool> canCheckBiometrics() async {
    try {
      final canCheck = await _localAuthentication.canCheckBiometrics;
      final isSupported = await _localAuthentication.isDeviceSupported();
      return canCheck && isSupported;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unlockWithBiometrics() async {
    if (!await canCheckBiometrics()) {
      return false;
    }

    try {
      return _localAuthentication.authenticate(
        localizedReason: 'Confirm your identity to unlock the vault',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  void resetLockTimer(VoidCallback onLock) {
    _lockTimer?.cancel();
    _lockTimer = Timer(lockTimeout, onLock);
  }

  void cancelLockTimer() {
    _lockTimer?.cancel();
    _lockTimer = null;
  }

  void dispose() {
    cancelLockTimer();
  }
}
