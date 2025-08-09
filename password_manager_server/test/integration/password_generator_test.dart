import 'package:test/test.dart';

// Import the generated test helper file.
// This file provides utilities to easily set up and run endpoint tests.
import 'test_tools/serverpod_test_tools.dart';

void main() {
  // Runs tests within a pre-configured Serverpod test environment.
  // The first argument is a description for the test group.
  withServerpod('Given PasswordGenerator endpoint',
      (sessionBuilder, endpoints) {
    test(
      // Describes the scenario being tested.
      'when calling `generatePassword` with a length of 12, then it returns a password of that length',
      () async {
        // Calls the generatePassword endpoint with a length of 12 characters.
        final password = await endpoints.passwordGenerator
            .generatePassword(sessionBuilder, length: 12);

        // Asserts that the returned password has the expected length.
        expect(password, hasLength(12));
      },
    );
  });
}
