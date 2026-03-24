import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';
import 'package:zk_password/data/sync/sync_service.dart';
import 'package:zk_password/domain/entities/vault_item.dart';

void main() {
  late CryptoService cryptoService;
  late SyncService syncService;
  late Uint8List keyBytes;

  final localOlder = VaultItem(
    id: 'github',
    title: 'GitHub',
    username: 'dev@example.com',
    password: 'old-password',
    createdAt: DateTime.parse('2026-03-24T00:00:00Z'),
    updatedAt: DateTime.parse('2026-03-24T00:00:00Z'),
  );

  final remoteNewer = VaultItem(
    id: 'github',
    title: 'GitHub',
    username: 'dev@example.com',
    password: 'new-password',
    createdAt: DateTime.parse('2026-03-24T00:00:00Z'),
    updatedAt: DateTime.parse('2026-03-25T00:00:00Z'),
  );

  setUp(() async {
    cryptoService = CryptoService();
    syncService = SyncService(cryptoService: cryptoService);
    keyBytes = Uint8List.fromList(
      List<int>.generate(32, (index) => index + 21),
    );
  });

  test('serializes, encrypts, and decrypts a snapshot', () async {
    final encrypted = await syncService.serializeAndEncrypt([
      localOlder,
    ], keyBytes);

    final decrypted = await syncService.decryptSnapshot(encrypted, keyBytes);

    expect(decrypted.single.password, localOlder.password);
    expect(decrypted.single.title, localOlder.title);
  });

  test('mergeLastWriteWins prefers the latest updated item', () {
    final merged = syncService.mergeLastWriteWins(
      localItems: [localOlder],
      remoteItems: [remoteNewer],
    );

    expect(merged, hasLength(1));
    expect(merged.single.password, 'new-password');
  });
}
