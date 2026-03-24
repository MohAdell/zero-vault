import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zk_password/core/crypto/crypto_service.dart';
import 'package:zk_password/domain/usecases/unlock_vault.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UnlockVault', () {
    late UnlockVault unlockVault;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues(<String, String>{});
      unlockVault = UnlockVault(
        cryptoService: CryptoService(),
        secureStorage: const FlutterSecureStorage(),
      );
    });

    test('creates a new vault on first unlock', () async {
      final result = await unlockVault('CorrectHorseBatteryStaple!');

      expect(result.status, UnlockStatus.created);
      expect(result.keyBytes, isNotNull);
      expect(await unlockVault.hasMasterPassword(), isTrue);
    });

    test('unlocks an existing vault with the correct password', () async {
      await unlockVault('CorrectHorseBatteryStaple!');

      final result = await unlockVault('CorrectHorseBatteryStaple!');

      expect(result.status, UnlockStatus.unlocked);
      expect(result.keyBytes, isNotNull);
    });

    test('rejects an invalid password for an existing vault', () async {
      await unlockVault('CorrectHorseBatteryStaple!');

      final result = await unlockVault('wrong-password');

      expect(result.status, UnlockStatus.invalidPassword);
      expect(result.keyBytes, isNull);
    });
  });
}
