import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';

enum UnlockStatus { created, unlocked, invalidPassword }

class UnlockVaultResult {
  const UnlockVaultResult({required this.status, this.keyBytes});

  final UnlockStatus status;
  final Uint8List? keyBytes;
}

class UnlockVault {
  UnlockVault({
    required CryptoService cryptoService,
    required FlutterSecureStorage secureStorage,
  }) : _cryptoService = cryptoService,
       _secureStorage = secureStorage;

  static const _saltKey = 'vault_salt';
  static const _verifierKey = 'vault_verifier';
  static const _verifierValue = 'zk_password::unlock_check';

  final CryptoService _cryptoService;
  final FlutterSecureStorage _secureStorage;

  Future<bool> hasMasterPassword() async {
    final salt = await _secureStorage.read(key: _saltKey);
    final verifier = await _secureStorage.read(key: _verifierKey);
    return salt != null && verifier != null;
  }

  Future<UnlockVaultResult> call(String masterPassword) async {
    final encodedSalt = await _secureStorage.read(key: _saltKey);
    final encodedVerifier = await _secureStorage.read(key: _verifierKey);

    if (encodedSalt == null || encodedVerifier == null) {
      final salt = _cryptoService.generateSalt();
      final keyBytes = await _cryptoService.deriveKeyBytes(
        masterPassword,
        salt,
      );
      final verifier = await _cryptoService.encrypt(_verifierValue, keyBytes);

      await _secureStorage.write(key: _saltKey, value: base64Encode(salt));
      await _secureStorage.write(key: _verifierKey, value: verifier);

      return UnlockVaultResult(
        status: UnlockStatus.created,
        keyBytes: keyBytes,
      );
    }

    final keyBytes = await _cryptoService.deriveKeyBytes(
      masterPassword,
      Uint8List.fromList(base64Decode(encodedSalt)),
    );

    try {
      final verifier = await _cryptoService.decrypt(encodedVerifier, keyBytes);
      if (verifier != _verifierValue) {
        _cryptoService.wipe(keyBytes);
        return const UnlockVaultResult(status: UnlockStatus.invalidPassword);
      }
    } catch (_) {
      _cryptoService.wipe(keyBytes);
      return const UnlockVaultResult(status: UnlockStatus.invalidPassword);
    }

    return UnlockVaultResult(status: UnlockStatus.unlocked, keyBytes: keyBytes);
  }
}
