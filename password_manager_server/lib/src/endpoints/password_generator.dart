import 'dart:math';

import 'package:serverpod/serverpod.dart';

/// Generates a random password of the specified length.
/// The password will contain at least one uppercase letter, one lowercase letter,
/// one number, and one special character.
class PasswordGeneratorEndpoint extends Endpoint {
  // All possible characters that can be used in the password.
  static const List<String> characters = [
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    'abcdefghijkmnpqrstuvwxyz', // Excludes 'l' and 'o' to avoid confusion.
    '23456789', // Excludes '0' and '1' to avoid confusion.
    '!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
  ];

  /// [length]: The desired length of the generated password.
  /// Returns a string containing the generated password.
  Future<String> generatePassword(
    Session session, {
    required final int length,
  }) async {
    final Random random = Random.secure();
    final List<String> password = [];

    // Helper function to get a random character from a given set of characters.
    String getRandomCharacter(String characters) =>
        characters[random.nextInt(characters.length)];

    for (final String charSet in characters) {
      password.add(getRandomCharacter(charSet));
    }

    // Fill the rest of the password with random characters from all categories.
    for (int i = password.length; i < length; i++) {
      password.add(getRandomCharacter(characters.join('')));
    }

    // Shuffle the characters to randomize the order.
    password.shuffle(random);
    return password.join('');
  }
}
