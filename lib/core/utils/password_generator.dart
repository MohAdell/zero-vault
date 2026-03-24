import 'dart:math';

class PasswordGenerator {
  static const _lowercase = 'abcdefghijkmnopqrstuvwxyz';
  static const _uppercase = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
  static const _digits = '23456789';
  static const _symbols = '!@#\$%^&*()-_=+[]{};:,.?';

  final Random _random;

  PasswordGenerator({Random? random}) : _random = random ?? Random.secure();

  String generate({
    int length = 20,
    bool includeUppercase = true,
    bool includeDigits = true,
    bool includeSymbols = true,
  }) {
    if (length < 12) {
      throw ArgumentError.value(
        length,
        'length',
        'Use at least 12 characters.',
      );
    }

    final pools = <String>[
      _lowercase,
      if (includeUppercase) _uppercase,
      if (includeDigits) _digits,
      if (includeSymbols) _symbols,
    ];

    final allCharacters = pools.join();
    final buffer = StringBuffer();

    for (final pool in pools) {
      buffer.write(pool[_random.nextInt(pool.length)]);
    }

    while (buffer.length < length) {
      buffer.write(allCharacters[_random.nextInt(allCharacters.length)]);
    }

    final characters = buffer.toString().split('');
    characters.shuffle(_random);
    return characters.join();
  }

  double estimateEntropy(String password) {
    var alphabetSize = 0;
    if (password.contains(RegExp(r'[a-z]'))) alphabetSize += _lowercase.length;
    if (password.contains(RegExp(r'[A-Z]'))) alphabetSize += _uppercase.length;
    if (password.contains(RegExp(r'[0-9]'))) alphabetSize += _digits.length;
    if (password.contains(RegExp(r'[^a-zA-Z0-9]'))) {
      alphabetSize += _symbols.length;
    }

    if (alphabetSize == 0) {
      return 0;
    }

    return password.length * (log(alphabetSize) / ln2);
  }
}
