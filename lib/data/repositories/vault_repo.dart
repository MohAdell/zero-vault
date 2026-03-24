import 'package:zk_password/data/models/vault_entry.dart';

abstract class VaultRepo {
  Future<List<VaultEntry>> getAll();
  Future<VaultEntry?> getByUuid(String uuid);
  Future<void> save(VaultEntry entry);
  Future<void> delete(String uuid);
  Future<void> clear();
}
