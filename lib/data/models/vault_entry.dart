import 'package:isar/isar.dart';

part 'vault_entry.g.dart';

@collection
class VaultEntry {
  VaultEntry({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.encTitle,
    required this.encUsername,
    required this.encPassword,
    this.encUrl,
    this.encNotes,
    this.encCategory,
    this.encTotpSecret,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });

  Id id;

  @Index(unique: true, replace: true)
  final String uuid;
  final String encTitle;
  final String encUsername;
  final String encPassword;
  final String? encUrl;
  final String? encNotes;
  final String? encCategory;
  final String? encTotpSecret;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;

  VaultEntry copyWith({
    Id? id,
    String? uuid,
    String? encTitle,
    String? encUsername,
    String? encPassword,
    String? encUrl,
    String? encNotes,
    String? encCategory,
    String? encTotpSecret,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return VaultEntry(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      encTitle: encTitle ?? this.encTitle,
      encUsername: encUsername ?? this.encUsername,
      encPassword: encPassword ?? this.encPassword,
      encUrl: encUrl ?? this.encUrl,
      encNotes: encNotes ?? this.encNotes,
      encCategory: encCategory ?? this.encCategory,
      encTotpSecret: encTotpSecret ?? this.encTotpSecret,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'encTitle': encTitle,
      'encUsername': encUsername,
      'encPassword': encPassword,
      'encUrl': encUrl,
      'encNotes': encNotes,
      'encCategory': encCategory,
      'encTotpSecret': encTotpSecret,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }

  factory VaultEntry.fromJson(Map<String, dynamic> json) {
    return VaultEntry(
      uuid: json['uuid'] as String,
      encTitle: json['encTitle'] as String,
      encUsername: json['encUsername'] as String,
      encPassword: json['encPassword'] as String,
      encUrl: json['encUrl'] as String?,
      encNotes: json['encNotes'] as String?,
      encCategory: json['encCategory'] as String?,
      encTotpSecret: json['encTotpSecret'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
