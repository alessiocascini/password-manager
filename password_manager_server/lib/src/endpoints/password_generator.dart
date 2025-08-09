import 'dart:math';

import 'package:serverpod/serverpod.dart';

/// Generates a random password of the specified length.
/// The password will contain at least one uppercase letter, one lowercase letter,
/// one number, and one special character.
class PasswordGeneratorEndpoint extends Endpoint {
  // Character groups used to build the password.
  static const List<String> characters = [
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    'abcdefghijkmnpqrstuvwxyz', // Excludes 'l' and 'o' to avoid confusion.
    '23456789', // Excludes '0' and '1' to avoid confusion.
    '!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
  ];

  /// Generates a password.
  ///
  /// [length]: Desired length of the generated password.
  /// Returns a string containing the generated password.
  Future<String> generatePassword(
    Session session, {
    required final int length,
  }) async {
    final Random random = Random.secure();
    final List<String> password = [];

    // Helper that returns a random character from the provided character set.
    String getRandomCharacter(String characters) =>
        characters[random.nextInt(characters.length)];

    // Ensure at least one character from each category is present.
    for (final String charSet in characters) {
      password.add(getRandomCharacter(charSet));
    }

    // Fill the remaining length with characters chosen from all categories.
    for (int i = password.length; i < length; i++) {
      password.add(getRandomCharacter(characters.join('')));
    }

    // Shuffle to avoid predictable ordering, then return as a single string.
    password.shuffle(random);
    return password.join('');
  }
}
