import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

class CryptoService {
  static const ivLength = 12;
  static const tagLength = 16;
  static const saltLength = 16;

  final AesGcm _aesGcm;
  final Random _random;

  CryptoService({AesGcm? aesGcm, Random? random})
    : _aesGcm = aesGcm ?? AesGcm.with256bits(),
      _random = random ?? Random.secure();

  Uint8List generateSalt([int length = saltLength]) {
    return Uint8List.fromList(
      List<int>.generate(length, (_) => _random.nextInt(256)),
    );
  }

  /// Derives DEK using Argon2id
  /// Intentionally blocks/takes time for brute force protection
  Future<Uint8List> deriveKeyBytes(String password, Uint8List salt) async {
    final kdf = Argon2id(
      iterations: 3,
      memory: 65536, // 64 MB
      parallelism: 4,
      hashLength: 32,
    );

    final secretKey = await kdf.deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );

    return Uint8List.fromList(await secretKey.extractBytes());
  }

  /// Encrypts plaintext ensuring a unique IV per operation.
  /// Output format: IV (12) + Tag (16) + Ciphertext
  Future<String> encrypt(String plaintext, Uint8List keyBytes) async {
    final iv = _aesGcm.newNonce();
    final secretBox = await _aesGcm.encrypt(
      utf8.encode(plaintext),
      secretKey: SecretKey(keyBytes),
      nonce: iv,
    );

    final resultBytes = Uint8List.fromList([
      ...secretBox.nonce,
      ...secretBox.mac.bytes,
      ...secretBox.cipherText,
    ]);

    return base64Encode(resultBytes);
  }

  /// Decrypts text based on the custom format IV + Tag + Ciphertext
  Future<String> decrypt(String base64Ciphertext, Uint8List keyBytes) async {
    final bytes = base64Decode(base64Ciphertext);
    if (bytes.length < ivLength + tagLength) {
      throw Exception('Invalid ciphertext format');
    }

    final iv = bytes.sublist(0, ivLength);
    final tagBytes = bytes.sublist(ivLength, ivLength + tagLength);
    final ciphertext = bytes.sublist(ivLength + tagLength);

    final secretBox = SecretBox(ciphertext, nonce: iv, mac: Mac(tagBytes));

    final plaintextBytes = await _aesGcm.decrypt(
      secretBox,
      secretKey: SecretKey(keyBytes),
    );

    return utf8.decode(plaintextBytes);
  }

  void wipe(Uint8List bytes) {
    bytes.fillRange(0, bytes.length, 0);
  }
}
