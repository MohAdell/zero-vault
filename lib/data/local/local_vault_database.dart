import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zk_password/data/models/vault_entry.dart';

class LocalVaultDatabase {
  static const _instanceName = 'zk_password_vault';

  static Future<Isar> open() async {
    final existing = Isar.getInstance(_instanceName);
    if (existing != null) {
      return existing;
    }

    final directory = await getApplicationSupportDirectory();
    return Isar.open(
      [VaultEntrySchema],
      directory: directory.path,
      name: _instanceName,
      inspector: kDebugMode,
    );
  }
}
