import 'dart:convert';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';
import 'package:zk_password/domain/entities/vault_item.dart';

class SyncService {
  SyncService({
    required CryptoService cryptoService,
    SupabaseClient? client,
    this.tableName = 'vault_snapshots',
  }) : _cryptoService = cryptoService,
       _client = client;

  final CryptoService _cryptoService;
  final SupabaseClient? _client;
  final String tableName;

  bool get isEnabled => _client != null;
  bool get isAuthenticated => _client?.auth.currentUser != null;

  Future<String> serializeAndEncrypt(
    List<VaultItem> items,
    Uint8List keyBytes,
  ) async {
    final json = jsonEncode(
      items.map((item) => item.toJson()).toList(growable: false),
    );
    return _cryptoService.encrypt(json, keyBytes);
  }

  Future<List<VaultItem>> decryptSnapshot(
    String encryptedBlob,
    Uint8List keyBytes,
  ) async {
    final json = await _cryptoService.decrypt(encryptedBlob, keyBytes);
    final decoded = jsonDecode(json) as List<dynamic>;
    return decoded
        .map((entry) => VaultItem.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  Future<void> uploadSnapshot(List<VaultItem> items, Uint8List keyBytes) async {
    final client = _client;
    final userId = client?.auth.currentUser?.id;
    if (client == null || userId == null) {
      return;
    }

    final encryptedBlob = await serializeAndEncrypt(items, keyBytes);
    await client.from(tableName).upsert({
      'user_id': userId,
      'encrypted_blob': encryptedBlob,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  Future<List<VaultItem>> downloadSnapshot(Uint8List keyBytes) async {
    final client = _client;
    final userId = client?.auth.currentUser?.id;
    if (client == null || userId == null) {
      return const <VaultItem>[];
    }

    final response = await client
        .from(tableName)
        .select('encrypted_blob')
        .eq('user_id', userId)
        .maybeSingle();

    final encryptedBlob = response?['encrypted_blob'] as String?;
    if (encryptedBlob == null || encryptedBlob.isEmpty) {
      return const <VaultItem>[];
    }

    return decryptSnapshot(encryptedBlob, keyBytes);
  }

  List<VaultItem> mergeLastWriteWins({
    required List<VaultItem> localItems,
    required List<VaultItem> remoteItems,
  }) {
    final merged = <String, VaultItem>{};
    for (final item in [...localItems, ...remoteItems]) {
      final previous = merged[item.id];
      if (previous == null || item.updatedAt.isAfter(previous.updatedAt)) {
        merged[item.id] = item;
      }
    }

    final result = merged.values.toList();
    result.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return result;
  }
}
