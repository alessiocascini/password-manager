import 'dart:io';
import 'dart:math';
import 'dart:convert';

Future<void> main() async {
  // final String password = generatePassword();

  try {
    File passwords = File('data/passwords.json');

    if (!await passwords.exists()) {
      print('File not found. Creating a new file...');
      await passwords.create(recursive: true);
      await passwords.writeAsString('{}');
    }

    String lines = await passwords.readAsString();

    if (lines.isEmpty) {
      print('File is empty. Writing default content...');
      await passwords.writeAsString('{}');
    }

    var map = jsonDecode(lines);

    if (map is! Map<String, dynamic>) {
      throw FormatException('The content of the file is not a map.');
    }

    print(map);
  } catch (e) {
    print(e);
  }

/*   try {
    File passwords = await File('data/passwords.txt').create(recursive: true);
    await passwords.writeAsString('Hello, World!\n', mode: FileMode.append);
    List<String> lines = await passwords.readAsLines();
    print(lines);
  } catch (e) {
    print(e);
  } */
}

String generatePassword() {
  const String upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String lowerCase = 'abcdefghijklmnopqrstuvwxyz';
  const String numbers = '0123456789';
  const String specialCharacters = '!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~';

  String characters = upperCase + lowerCase + numbers + specialCharacters;
  characters = characters.replaceAll(RegExp(r'[l1o0]'), '');

  int length = 0;

  while (true) {
    try {
      print('Enter the length of the password: ');
      String? input = stdin.readLineSync();

      if (input?.trim().isEmpty ?? true) {
        throw ArgumentError('The length of the password cannot be empty.');
      }

      if (int.tryParse(input!) == null) {
        throw FormatException('The length of the password must be a number.');
      } else {
        length = int.parse(input);
      }

      if (length < 8 || length > 128) {
        throw RangeError(
            'The length of the password must be between 8 and 128.');
      }

      break;
    } catch (e) {
      print(e);
    }
  }

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
