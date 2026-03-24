import 'package:isar/isar.dart';
import 'package:zk_password/data/models/vault_entry.dart';
import 'package:zk_password/data/repositories/vault_repo.dart';

class VaultRepoImpl implements VaultRepo {
  VaultRepoImpl(this._isar);

  VaultRepoImpl.inMemory() : _isar = null;

  final Isar? _isar;

  final Map<String, VaultEntry> _memoryStore = <String, VaultEntry>{};

  @override
  Future<void> clear() async {
    final isar = _isar;
    if (isar != null) {
      await isar.writeTxn(() => isar.vaultEntrys.clear());
      return;
    }

    _memoryStore.clear();
  }

  @override
  Future<void> delete(String uuid) async {
    final isar = _isar;
    if (isar != null) {
      final entry = await getByUuid(uuid);
      if (entry == null) {
        return;
      }

      await isar.writeTxn(() => isar.vaultEntrys.delete(entry.id));
      return;
    }

    _memoryStore.remove(uuid);
  }

  @override
  Future<List<VaultEntry>> getAll() async {
    final isar = _isar;
    if (isar != null) {
      final entries = await isar.txn(() => isar.vaultEntrys.where().findAll());
      entries.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return entries;
    }

    final entries = _memoryStore.values
        .map((entry) => entry.copyWith())
        .toList();
    entries.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return entries;
  }

  @override
  Future<VaultEntry?> getByUuid(String uuid) async {
    final isar = _isar;
    if (isar != null) {
      return isar.txn(
        () => isar.vaultEntrys.where().uuidEqualTo(uuid).findFirst(),
      );
    }

    final entry = _memoryStore[uuid];
    return entry?.copyWith();
  }

  @override
  Future<void> save(VaultEntry entry) async {
    final isar = _isar;
    if (isar != null) {
      await isar.writeTxn(() => isar.vaultEntrys.put(entry));
      return;
    }

    _memoryStore[entry.uuid] = entry.copyWith();
  }
}
