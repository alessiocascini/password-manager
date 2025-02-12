import 'dart:io';
import 'dart:math';

/// A class to generate secure random passwords.
class PasswordGenerator {
  // Constants representing different character sets for password generation.
  static const String _upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String _lowerCase =
      'abcdefghijkmnpqrstuvwxyz'; // Excludes 'l' and 'o' to avoid confusion.
  static const String _numbers =
      '23456789'; // Excludes '0' and '1' to avoid confusion.
  static const String _specialCharacters =
      '!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~';

  // All possible characters that can be used in the password.
  static const String _characters =
      _upperCase + _lowerCase + _numbers + _specialCharacters;

  // The generated password.
  String password = '';

  /// Constructor that generates a password with a length based on user input.
  PasswordGenerator() {
    final int length = _getLength();
    password = _generatePassword(length);
    print('Password: $password');
  }

  /// Prompts the user to input a password length between 8 and 128.
  /// Returns the length as an integer.
  int _getLength() {
    while (true) {
      print('Enter the length of the password: ');
      final String input = stdin.readLineSync() ?? '';

      // Ensures the input is not empty.
      if (input.trim().isEmpty) {
        print('The length must not be empty.');
        continue;
      }

      // Tries to parse the input as an integer.
      final int? length = int.tryParse(input);

      // Validates that the length is an integer and within the acceptable range.
      if (length == null) {
        print('The length must be an integer.');
      } else if (length < 8 || length > 128) {
        print('The length must be between 8 and 128.');
      } else {
        return length;
      }
    }
  }

  /// Generates a random password of the specified length.
  /// The password will contain at least one uppercase letter, one lowercase letter,
  /// one number, and one special character.
  ///
  /// [length]: The desired length of the generated password.
  /// Returns a string containing the generated password.
  String _generatePassword(int length) {
    final Random random = Random.secure();
    final List<String> password = [];

    // Helper function to get a random character from a given set of characters.
    String getRandomCharacter(String characters) =>
        characters[random.nextInt(characters.length)];

    // Ensure the password contains at least one character from each category.
    password.add(getRandomCharacter(_upperCase));
    password.add(getRandomCharacter(_lowerCase));
    password.add(getRandomCharacter(_numbers));
    password.add(getRandomCharacter(_specialCharacters));

    // Fill the rest of the password with random characters from all categories.
    for (int i = password.length; i < length; i++) {
      password.add(getRandomCharacter(_characters));
    }

    // Shuffle the characters to randomize the order.
    password.shuffle(random);
    return password.join('');
  }
}
