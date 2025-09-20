import 'package:password_manager_server/src/generated/protocol.dart';
import 'package:password_manager_server/src/services/hash_manager.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  // Set up a Serverpod test context specifically for the login endpoint tests.
  // This block focuses only on the authentication behavior via `login`.
  withServerpod('Given UserEndpoint for login only',
      (sessionBuilder, endpoints) {
    test(
      // Scenario: login with correct username and password
      'when logging in with valid credentials, then it returns the user successfully',
      () async {
        // Arrange: register a user first so we have valid credentials
        final String username = 'loginUser';
        final String password = 'SecurePassword!23';

        final User registeredUser = await endpoints.user.register(
          sessionBuilder,
          username: username,
          password: password,
        );

        // Act: attempt login with same credentials
        final User loggedInUser = await endpoints.user.login(
          sessionBuilder,
          username: username,
          password: password,
        );

        // Assert: verify login returns correct user and hashed master matches
        expect(loggedInUser.id, equals(registeredUser.id));
        expect(loggedInUser.username, equals(registeredUser.username));

        final String expectedHash = HashManager.hash(
          plain: password,
          salt: registeredUser.salt,
        );
        expect(loggedInUser.master, equals(expectedHash));
      },
    );

    test(
      // Scenario: login with incorrect password
      'when logging in with invalid password, then it throws an exception',
      () async {
        // Arrange: register user
        final String username = 'loginUser2';
        final String password = 'CorrectPassword!45';

        await endpoints.user.register(
          sessionBuilder,
          username: username,
          password: password,
        );

        // Act & Assert: attempt login with wrong password should fail
        expect(
          () async => await endpoints.user.login(
            sessionBuilder,
            username: username,
            password: 'WrongPassword',
          ),
          throwsA(isA<Exception>()),
        );
      },
    );

    test(
      // Scenario: login with non-existent username
      'when logging in with username that does not exist, then it throws an exception',
      () async {
        final String username = 'nonexistent';
        final String password = 'AnyPassword';

        // Act & Assert: login should fail because user isn’t registered
        expect(
          () async => await endpoints.user.login(
            sessionBuilder,
            username: username,
            password: password,
          ),
          throwsA(isA<Exception>()),
        );
      },
    );
  });
}
