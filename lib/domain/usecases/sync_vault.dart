import 'dart:typed_data';

import 'package:zk_password/data/sync/sync_service.dart';
import 'package:zk_password/domain/entities/vault_item.dart';

class SyncVault {
  SyncVault(this._syncService);

  final SyncService _syncService;

  Future<List<VaultItem>> call({
    required List<VaultItem> localItems,
    required Uint8List keyBytes,
  }) async {
    final remoteItems = await _syncService.downloadSnapshot(keyBytes);
    final merged = _syncService.mergeLastWriteWins(
      localItems: localItems,
      remoteItems: remoteItems,
    );
    await _syncService.uploadSnapshot(merged, keyBytes);
    return merged;
  }
}
