import 'package:password_manager_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  // Set up a Serverpod test context specifically for the PasswordGenerator endpoint.
  // This block only tests password generation behavior.
  withServerpod('Given PasswordGenerator endpoint',
      (sessionBuilder, endpoints) {
    test(
      // Scenario: generating a password of a specific length and character set.
      'when calling `generatePassword` with a length of 12, then it returns a password of that length',
      () async {
        // Act: call the generatePassword endpoint with specified parameters.
        final password = await endpoints.passwordGenerator.generatePassword(
          sessionBuilder,
          length: 12,
          charSets: {CharSet.uppercase, CharSet.lowercase, CharSet.numbers},
          excludeAmbiguous: true,
        );

        // Assert: the returned password should have exactly 12 characters.
        expect(password, hasLength(12),
            reason: 'Password must match the requested length');
      },
    );
  });
}
