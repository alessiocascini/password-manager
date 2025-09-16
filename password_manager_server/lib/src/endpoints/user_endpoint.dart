import 'dart:async';

import 'package:password_manager_server/src/generated/protocol.dart';
import 'package:password_manager_server/src/services/hash_manager.dart';
import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  Future<User> register(
    Session session, {
    required String username,
    required String password,
  }) async {
    final User? user = await User.db
        .findFirstRow(session, where: (t) => t.username.equals(username));

    if (user != null) throw Exception('Username already exists');

    final String salt = HashManager.generateSalt();
    final String master = HashManager.hash(plain: password, salt: salt);

    return await User.db.insertRow(
        session, User(username: username, salt: salt, master: master));
  }

  Future<User> login(
    Session session, {
    required String username,
    required String password,
  }) async {
    final User? user = await User.db
        .findFirstRow(session, where: (t) => t.username.equals(username));

    if (user == null) throw Exception('Invalid username or password');

    // Here you would typically verify the password using your hashing mechanism.
    // For simplicity, this example does not include password verification logic.

    return user;
  }
}
