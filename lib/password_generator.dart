import 'dart:io';
import 'dart:math';

String generatePassword() {
  const String upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String lowerCase = 'abcdefghijklmnopqrstuvwxyz';
  const String numbers = '0123456789';
  const String specialCharacters = '!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~';

  String characters = upperCase + lowerCase + numbers + specialCharacters;
  characters = characters.replaceAll(RegExp(r'[l1o0]'), '');

  int length = 0;

  do {
    try {
      print('Enter the length of the password: ');
      String input = stdin.readLineSync() ?? '';

      if (input.trim().isEmpty) {
        throw ArgumentError('The length of the password cannot be empty.');
      }

      if (int.tryParse(input) == null) {
        throw FormatException('The length of the password must be a number.');
      } else {
        length = int.parse(input);
      }

      if (length < 8 || length > 128) {
        print('The length of the password must be between 8 and 128.');
      }

      break;
    } catch (e) {
      print(e);
    }
  } while (length < 8 || length > 128);

  String password;
  final Random random = Random();

  do {
    password = '';
    for (int i = 0; i < length; i++) {
      password += characters[random.nextInt(characters.length)];
    }
  } while (!(password.contains(RegExp('[$upperCase]')) &&
      password.contains(RegExp('[$lowerCase]')) &&
      password.contains(RegExp('[$numbers]')) &&
      password.contains(RegExp('[$specialCharacters]'))));

  print('Password: $password');

  return password;
}
