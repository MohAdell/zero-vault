import 'dart:typed_data';

import 'package:zk_password/data/models/vault_entry_codec.dart';
import 'package:zk_password/data/repositories/vault_repo.dart';
import 'package:zk_password/domain/entities/vault_item.dart';

class AddEntry {
  AddEntry({required VaultRepo vaultRepo, required VaultEntryCodec entryCodec})
    : _vaultRepo = vaultRepo,
      _entryCodec = entryCodec;

  final VaultRepo _vaultRepo;
  final VaultEntryCodec _entryCodec;

  Future<void> call({
    required VaultItem item,
    required Uint8List keyBytes,
  }) async {
    final existing = await _vaultRepo.getByUuid(item.id);
    final entry = await _entryCodec.encrypt(
      item,
      keyBytes,
      existingId: existing?.id,
    );
    await _vaultRepo.save(entry);
  }
}
