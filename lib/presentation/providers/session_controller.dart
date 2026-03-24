import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zk_password/core/auth/auth_service.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';
import 'package:zk_password/domain/usecases/unlock_vault.dart';

class SessionState {
  const SessionState({
    this.initialized = false,
    this.hasMasterPassword = false,
    this.isBusy = false,
    this.isUnlocked = false,
    this.biometricAvailable = false,
    this.requiresBiometricReentry = false,
    this.keyBytes,
    this.errorMessage,
  });

  final bool initialized;
  final bool hasMasterPassword;
  final bool isBusy;
  final bool isUnlocked;
  final bool biometricAvailable;
  final bool requiresBiometricReentry;
  final Uint8List? keyBytes;
  final String? errorMessage;

  bool get needsSetup => initialized && !hasMasterPassword;

  SessionState copyWith({
    bool? initialized,
    bool? hasMasterPassword,
    bool? isBusy,
    bool? isUnlocked,
    bool? biometricAvailable,
    bool? requiresBiometricReentry,
    Object? keyBytes = _sentinel,
    Object? errorMessage = _sentinel,
  }) {
    return SessionState(
      initialized: initialized ?? this.initialized,
      hasMasterPassword: hasMasterPassword ?? this.hasMasterPassword,
      isBusy: isBusy ?? this.isBusy,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      biometricAvailable: biometricAvailable ?? this.biometricAvailable,
      requiresBiometricReentry:
          requiresBiometricReentry ?? this.requiresBiometricReentry,
      keyBytes: keyBytes == _sentinel ? this.keyBytes : keyBytes as Uint8List?,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  static const Object _sentinel = Object();
}

class SessionController extends StateNotifier<SessionState> {
  SessionController({
    required UnlockVault unlockVault,
    required AuthService authService,
    required CryptoService cryptoService,
  }) : _unlockVault = unlockVault,
       _authService = authService,
       _cryptoService = cryptoService,
       super(const SessionState()) {
    unawaited(_bootstrap());
  }

  final UnlockVault _unlockVault;
  final AuthService _authService;
  final CryptoService _cryptoService;

  Future<void> _bootstrap() async {
    final hasMasterPassword = await _unlockVault.hasMasterPassword();
    final biometricAvailable = await _authService.canCheckBiometrics();
    state = state.copyWith(
      initialized: true,
      hasMasterPassword: hasMasterPassword,
      biometricAvailable: biometricAvailable,
    );
  }

  Future<bool> unlock(String masterPassword) async {
    if (masterPassword.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Enter a master password first.');
      return false;
    }

    state = state.copyWith(isBusy: true, errorMessage: null);

    final result = await _unlockVault(masterPassword);
    final keyBytes = result.keyBytes;

    switch (result.status) {
      case UnlockStatus.created:
      case UnlockStatus.unlocked:
        _replaceKey(keyBytes!);
        _authService.resetLockTimer(lock);
        state = state.copyWith(
          initialized: true,
          hasMasterPassword: true,
          isBusy: false,
          isUnlocked: true,
          requiresBiometricReentry: false,
          keyBytes: keyBytes,
          errorMessage: null,
        );
        return true;
      case UnlockStatus.invalidPassword:
        state = state.copyWith(
          isBusy: false,
          isUnlocked: false,
          errorMessage: 'Invalid master password.',
        );
        return false;
    }
  }

  void touch() {
    if (state.isUnlocked && !state.requiresBiometricReentry) {
      _authService.resetLockTimer(lock);
    }
  }

  void markBackgrounded() {
    if (!state.isUnlocked || state.isBusy) {
      return;
    }

    if (!state.biometricAvailable) {
      lock();
      return;
    }

    state = state.copyWith(requiresBiometricReentry: true);
  }

  Future<bool> reauthenticateSession() async {
    if (!state.requiresBiometricReentry) {
      return true;
    }

    state = state.copyWith(isBusy: true, errorMessage: null);
    final unlocked = await _authService.unlockWithBiometrics();

    if (!unlocked) {
      state = state.copyWith(
        isBusy: false,
        errorMessage: 'Biometric verification failed.',
      );
      return false;
    }

    _authService.resetLockTimer(lock);
    state = state.copyWith(
      isBusy: false,
      requiresBiometricReentry: false,
      errorMessage: null,
    );
    return true;
  }

  void lock() {
    _authService.cancelLockTimer();
    if (state.keyBytes != null) {
      _cryptoService.wipe(state.keyBytes!);
    }

    state = state.copyWith(
      isBusy: false,
      isUnlocked: false,
      requiresBiometricReentry: false,
      keyBytes: null,
      errorMessage: null,
    );
  }

  void _replaceKey(Uint8List nextKey) {
    final previousKey = state.keyBytes;
    if (previousKey != null && !identical(previousKey, nextKey)) {
      _cryptoService.wipe(previousKey);
    }
  }

  @override
  void dispose() {
    lock();
    _authService.dispose();
    super.dispose();
  }
}
