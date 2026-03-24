import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';
import 'package:zk_password/data/models/vault_entry.dart';
import 'package:zk_password/domain/entities/vault_item.dart';

class VaultEntryCodec {
  VaultEntryCodec(this._cryptoService);

  final CryptoService _cryptoService;

  Future<VaultEntry> encrypt(
    VaultItem item,
    Uint8List keyBytes, {
    int? existingId,
  }) async {
    return VaultEntry(
      id: existingId ?? Isar.autoIncrement,
      uuid: item.id,
      encTitle: await _cryptoService.encrypt(item.title, keyBytes),
      encUsername: await _cryptoService.encrypt(item.username, keyBytes),
      encPassword: await _cryptoService.encrypt(item.password, keyBytes),
      encUrl: item.url == null || item.url!.isEmpty
          ? null
          : await _cryptoService.encrypt(item.url!, keyBytes),
      encNotes: item.notes == null || item.notes!.isEmpty
          ? null
          : await _cryptoService.encrypt(item.notes!, keyBytes),
      encCategory: item.category == null || item.category!.isEmpty
          ? null
          : await _cryptoService.encrypt(item.category!, keyBytes),
      encTotpSecret: item.totpSecret == null || item.totpSecret!.isEmpty
          ? null
          : await _cryptoService.encrypt(item.totpSecret!, keyBytes),
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
      isFavorite: item.isFavorite,
    );
  }

  Future<VaultItem> decrypt(VaultEntry entry, Uint8List keyBytes) async {
    return VaultItem(
      id: entry.uuid,
      title: await _cryptoService.decrypt(entry.encTitle, keyBytes),
      username: await _cryptoService.decrypt(entry.encUsername, keyBytes),
      password: await _cryptoService.decrypt(entry.encPassword, keyBytes),
      url: entry.encUrl == null
          ? null
          : await _cryptoService.decrypt(entry.encUrl!, keyBytes),
      notes: entry.encNotes == null
          ? null
          : await _cryptoService.decrypt(entry.encNotes!, keyBytes),
      category: entry.encCategory == null
          ? null
          : await _cryptoService.decrypt(entry.encCategory!, keyBytes),
      totpSecret: entry.encTotpSecret == null
          ? null
          : await _cryptoService.decrypt(entry.encTotpSecret!, keyBytes),
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      isFavorite: entry.isFavorite,
    );
  }
}
