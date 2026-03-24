import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zk_password/data/models/vault_entry_codec.dart';
import 'package:zk_password/data/repositories/vault_repo.dart';
import 'package:zk_password/domain/entities/vault_item.dart';
import 'package:zk_password/domain/usecases/add_entry.dart';
import 'package:zk_password/domain/usecases/sync_vault.dart';

class VaultState {
  const VaultState({
    this.items = const <VaultItem>[],
    this.query = '',
    this.isLoading = false,
    this.message,
  });

  final List<VaultItem> items;
  final String query;
  final bool isLoading;
  final String? message;

  List<VaultItem> get filteredItems {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return items;
    }

    return items.where((item) {
      return item.title.toLowerCase().contains(normalizedQuery) ||
          item.username.toLowerCase().contains(normalizedQuery) ||
          (item.category ?? '').toLowerCase().contains(normalizedQuery) ||
          (item.url ?? '').toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  VaultState copyWith({
    List<VaultItem>? items,
    String? query,
    bool? isLoading,
    Object? message = _sentinel,
  }) {
    return VaultState(
      items: items ?? this.items,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      message: message == _sentinel ? this.message : message as String?,
    );
  }

  static const Object _sentinel = Object();
}

class VaultController extends StateNotifier<VaultState> {
  VaultController({
    required VaultRepo vaultRepo,
    required VaultEntryCodec entryCodec,
    required AddEntry addEntry,
    required SyncVault syncVault,
  }) : _vaultRepo = vaultRepo,
       _entryCodec = entryCodec,
       _addEntry = addEntry,
       _syncVault = syncVault,
       super(const VaultState());

  final VaultRepo _vaultRepo;
  final VaultEntryCodec _entryCodec;
  final AddEntry _addEntry;
  final SyncVault _syncVault;

  Future<void> load(Uint8List keyBytes) async {
    state = state.copyWith(isLoading: true, message: null);
    try {
      final entries = await _vaultRepo.getAll();
      final items = <VaultItem>[];
      for (final entry in entries) {
        items.add(await _entryCodec.decrypt(entry, keyBytes));
      }

      state = state.copyWith(items: items, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Failed to load the vault.',
      );
    }
  }

  Future<void> saveItem({
    required VaultItem item,
    required Uint8List keyBytes,
  }) async {
    state = state.copyWith(isLoading: true, message: null);
    try {
      await _addEntry(item: item, keyBytes: keyBytes);
      await load(keyBytes);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Could not save the entry.',
      );
    }
  }

  Future<void> deleteItem({
    required String id,
    required Uint8List keyBytes,
  }) async {
    state = state.copyWith(isLoading: true, message: null);
    try {
      await _vaultRepo.delete(id);
      await load(keyBytes);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Could not delete the entry.',
      );
    }
  }

  Future<void> sync(Uint8List keyBytes) async {
    state = state.copyWith(isLoading: true, message: null);
    try {
      final merged = await _syncVault(
        localItems: state.items,
        keyBytes: keyBytes,
      );
      state = state.copyWith(
        items: merged,
        isLoading: false,
        message: 'Sync completed.',
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        message: 'Sync skipped. Configure Supabase to enable it.',
      );
    }
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void clear() {
    state = const VaultState();
  }
}
