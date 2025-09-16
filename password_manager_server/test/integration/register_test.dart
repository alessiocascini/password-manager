import 'package:password_manager_server/src/generated/protocol.dart';
import 'package:password_manager_server/src/services/hash_manager.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  // Set up a Serverpod test context specifically for registration tests.
  // The description makes it explicit that this block is for the `register`
  // endpoint only and does not include login behavior.
  withServerpod('Given UserEndpoint for register only',
      (sessionBuilder, endpoints) {
    test(
      // Scenario: successful registration of a new, unique user.
      'when registering a new user with unique username, then it creates the user successfully',
      () async {
        // Arrange: input values for the test.
        final String username = 'testUser';
        final String password = 'TestPassword123!';

        // Act: call the register endpoint using the test session.
        final User user = await endpoints.user.register(
          sessionBuilder,
          username: username,
          password: password,
        );

        // Assert: basic expectations about the returned User object.
        expect(user.username, equals(username));
        expect(user.salt, isNotEmpty,
            reason: 'Salt should be generated and not empty');
        expect(user.master, isNotEmpty,
            reason: 'Master hash should be present and not empty');

        // Assert: verify that the stored master hash matches the value
        // computed locally using the same HashManager implementation.
        final String expectedHash =
            HashManager.hash(plain: password, salt: user.salt);
        expect(user.master, equals(expectedHash),
            reason: 'Stored hash must match computed hash');
      },
    );

    test(
      // Scenario: attempting to register a username that already exists.
      'when registering a user with an existing username, then it throws an exception',
      () async {
        // Arrange: a username that will be created first.
        final String username = 'duplicateUser';
        final String password = 'Password1!';

        // Act: create the first user successfully.
        await endpoints.user.register(
          sessionBuilder,
          username: username,
          password: password,
        );

        // Assert: the second registration with the same username should fail.
        // We expect the endpoint to throw an Exception (duplicate username).
        expect(
          () async => await endpoints.user.register(
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
