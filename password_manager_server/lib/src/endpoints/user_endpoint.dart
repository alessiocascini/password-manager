import 'dart:async';

import 'package:password_manager_server/src/generated/protocol.dart';
import 'package:password_manager_server/src/services/hash_manager.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint that handles user registration and authentication.
///
/// Responsibilities:
/// - Register new users with a salted master-hash (no plaintext master password
///   is ever stored).
/// - Authenticate users by verifying the provided master password against the
///   stored hash.
///
/// Security notes:
/// - The endpoint expects the caller to supply a plaintext master password
///   which is immediately processed (salted + hashed) and never persisted in
///   cleartext.
/// - For production use consider returning a more specific error type than a
///   generic [Exception] to avoid leaking information (e.g. always return a
///   generic authentication error message on login failures).
class UserEndpoint extends Endpoint {
  /// Registers a new user.
  ///
  /// Parameters:
  /// - [session]: The Serverpod session/context for the request.
  /// - [username]: Unique username chosen by the user.
  /// - [password]: The plaintext master password provided during registration.
  ///
  /// Returns: The newly created [User] record as stored in the database.
  ///
  /// Throws:
  /// - [Exception] if a user with the same [username] already exists.
  ///
  /// Implementation details:
  /// - Generates a cryptographically secure salt via [HashManager.generateSalt].
  /// - Computes the stored master hash with [HashManager.hash].
  /// - Inserts the user record using Serverpod's generated DB helper.
  Future<User> register(
    Session session, {
    required String username,
    required String password,
  }) async {
    // Check for existing user with the same username.
    final User? user = await User.db
        .findFirstRow(session, where: (t) => t.username.equals(username));

    if (user != null) throw Exception('Username already exists');

    // Generate salt and compute master hash (salt + password).
    final String salt = HashManager.generateSalt();
    final String master = HashManager.hash(plain: password, salt: salt);

    // Persist the new user and return the created record (including DB id).
    return await User.db.insertRow(
        session, User(username: username, salt: salt, master: master));
  }

  /// Authenticates a user by verifying the provided master password.
  ///
  /// Parameters:
  /// - [session]: The Serverpod session/context for the request.
  /// - [username]: The username to authenticate.
  /// - [password]: The plaintext master password to verify.
  ///
  /// Returns: The matching [User] record when authentication succeeds.
  ///
  /// Throws:
  /// - [Exception] if authentication fails (user not found or password
  ///   mismatch). Consider returning a uniform error message to avoid
  ///   disclosing whether the username exists.
  Future<User> login(
    Session session, {
    required String username,
    required String password,
  }) async {
    // Lookup user by username.
    final User? user = await User.db
        .findFirstRow(session, where: (t) => t.username.equals(username));

    if (user == null) throw Exception('Invalid username or password');

    // Recompute hash using the stored salt and compare to the persisted hash.
    final String master = HashManager.hash(plain: password, salt: user.salt);
    if (master != user.master) throw Exception('Invalid username or password');

    // Authentication successful: return the user record.
    return user;
  }
}
