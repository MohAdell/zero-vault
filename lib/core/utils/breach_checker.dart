import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:http/http.dart' as http;

class BreachCheckResult {
  const BreachCheckResult({required this.breachCount, required this.prefix});

  final int breachCount;
  final String prefix;

  bool get isPwned => breachCount > 0;
}

class BreachChecker {
  BreachChecker({http.Client? client, HashAlgorithm? hashAlgorithm})
    : _client = client ?? http.Client(),
      _hashAlgorithm = hashAlgorithm ?? Sha1();

  final http.Client _client;
  final HashAlgorithm _hashAlgorithm;

  Future<BreachCheckResult> checkPassword(String password) async {
    final digest = await _hashAlgorithm.hash(utf8.encode(password));
    final hash = _hexEncode(digest.bytes).toUpperCase();
    final prefix = hash.substring(0, 5);
    final suffix = hash.substring(5);

    final response = await _client.get(
      Uri.parse('https://api.pwnedpasswords.com/range/$prefix'),
      headers: const {'Add-Padding': 'true', 'User-Agent': 'zk_password'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to check password breach status.');
    }

    for (final line in const LineSplitter().convert(response.body)) {
      final parts = line.split(':');
      if (parts.length != 2) {
        continue;
      }

      if (parts.first.trim().toUpperCase() == suffix) {
        return BreachCheckResult(
          breachCount: int.tryParse(parts.last.trim()) ?? 0,
          prefix: prefix,
        );
      }
    }

    return BreachCheckResult(breachCount: 0, prefix: prefix);
  }

  void dispose() {
    _client.close();
  }

  String _hexEncode(List<int> bytes) {
    final buffer = StringBuffer();
    for (final byte in bytes) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }
}
