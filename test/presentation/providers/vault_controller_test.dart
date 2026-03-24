import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';
import 'package:zk_password/data/models/vault_entry_codec.dart';
import 'package:zk_password/data/repositories/vault_repo_impl.dart';
import 'package:zk_password/data/sync/sync_service.dart';
import 'package:zk_password/domain/entities/vault_item.dart';
import 'package:zk_password/domain/usecases/add_entry.dart';
import 'package:zk_password/domain/usecases/sync_vault.dart';
import 'package:zk_password/presentation/providers/vault_controller.dart';

void main() {
  late CryptoService cryptoService;
  late VaultRepoImpl vaultRepo;
  late VaultEntryCodec vaultEntryCodec;
  late AddEntry addEntry;
  late VaultController vaultController;
  late Uint8List keyBytes;

  setUp(() async {
    cryptoService = CryptoService();
    vaultRepo = VaultRepoImpl.inMemory();
    vaultEntryCodec = VaultEntryCodec(cryptoService);
    addEntry = AddEntry(vaultRepo: vaultRepo, entryCodec: vaultEntryCodec);
    vaultController = VaultController(
      vaultRepo: vaultRepo,
      entryCodec: vaultEntryCodec,
      addEntry: addEntry,
      syncVault: SyncVault(SyncService(cryptoService: cryptoService)),
    );
    keyBytes = Uint8List.fromList(List<int>.generate(32, (index) => index + 1));
  });

  test('saveItem persists and load decrypts the entry list', () async {
    final item = VaultItem(
      id: '1',
      title: 'GitHub',
      username: 'dev@example.com',
      password: 's3cret!',
      category: 'Work',
      createdAt: DateTime.parse('2026-03-24T00:00:00Z'),
      updatedAt: DateTime.parse('2026-03-24T00:00:00Z'),
    );

    await vaultController.saveItem(item: item, keyBytes: keyBytes);

    expect(vaultController.state.items, hasLength(1));
    expect(vaultController.state.items.single.title, 'GitHub');
    expect(vaultController.state.items.single.password, 's3cret!');
  });

  test('setQuery filters decrypted items in memory', () async {
    final item = VaultItem(
      id: '1',
      title: 'GitHub',
      username: 'dev@example.com',
      password: 's3cret!',
      category: 'Work',
      createdAt: DateTime.parse('2026-03-24T00:00:00Z'),
      updatedAt: DateTime.parse('2026-03-24T00:00:00Z'),
    );

    await vaultController.saveItem(item: item, keyBytes: keyBytes);
    vaultController.setQuery('git');

    expect(vaultController.state.filteredItems, hasLength(1));
    expect(vaultController.state.filteredItems.single.id, '1');
  });
}
