class VaultItem {
  const VaultItem({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    this.url,
    this.notes,
    this.category,
    this.totpSecret,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String username;
  final String password;
  final String? url;
  final String? notes;
  final String? category;
  final String? totpSecret;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;

  VaultItem copyWith({
    String? id,
    String? title,
    String? username,
    String? password,
    String? url,
    String? notes,
    String? category,
    String? totpSecret,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return VaultItem(
      id: id ?? this.id,
      title: title ?? this.title,
      username: username ?? this.username,
      password: password ?? this.password,
      url: url ?? this.url,
      notes: notes ?? this.notes,
      category: category ?? this.category,
      totpSecret: totpSecret ?? this.totpSecret,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'password': password,
      'url': url,
      'notes': notes,
      'category': category,
      'totpSecret': totpSecret,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }

  factory VaultItem.fromJson(Map<String, dynamic> json) {
    return VaultItem(
      id: json['id'] as String,
      title: json['title'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      url: json['url'] as String?,
      notes: json['notes'] as String?,
      category: json['category'] as String?,
      totpSecret: json['totpSecret'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
