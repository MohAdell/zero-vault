import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';

void main() {
  late CryptoService cryptoService;
  late Uint8List fixedKeyBytes;

  setUp(() {
    cryptoService = CryptoService();
    fixedKeyBytes = Uint8List.fromList(
      List<int>.generate(32, (index) => index + 11),
    );
  });

  group('CryptoService Tests', () {
    test(
      'deriveKeyBytes returns a 32-byte key',
      () async {
        final salt = Uint8List.fromList(utf8.encode('random_salt_for_testing'));
        final derivedKey = await cryptoService.deriveKeyBytes(
          'SuperSecretMasterPassword123!',
          salt,
        );

        expect(derivedKey, hasLength(32));
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test('encrypt(decrypt(x)) == x', () async {
      final plaintext = 'Sensitive Vault Data 123';

      // Encrypt
      final ciphertext = await cryptoService.encrypt(plaintext, fixedKeyBytes);

      // Decrypt
      final decrypted = await cryptoService.decrypt(ciphertext, fixedKeyBytes);

      expect(decrypted, equals(plaintext));
    });

    test('encrypt(x) != encrypt(x) due to random IV', () async {
      final plaintext = 'Identical Payload';

      // Encrypt two times
      final ciphertext1 = await cryptoService.encrypt(plaintext, fixedKeyBytes);
      final ciphertext2 = await cryptoService.encrypt(plaintext, fixedKeyBytes);

      expect(ciphertext1, isNot(equals(ciphertext2)));
    });

    test('decrypt throws on malformed ciphertext', () async {
      expect(
        () => cryptoService.decrypt('Zm9v', fixedKeyBytes),
        throwsException,
      );
    });
  });
}
