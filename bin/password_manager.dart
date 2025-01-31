import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:password_manager/password_generator.dart';

Future<void> main() async {
  final File master = File('data/master.json');
  Map<String, dynamic> map = await readFile(master);

  if (map.isEmpty) {
    final Random random = Random.secure();
    final List<int> saltBytes =
        List<int>.generate(16, (_) => random.nextInt(256));
    final String salt = base64.encode(saltBytes);

    print('Salt: $salt');

    String password;

    print('Enter the master password: ');
    do {
      password = stdin.readLineSync() ?? '';
    } while (password.trim().isEmpty);

    final bytes = utf8.encode(password + salt);
    final Digest digest = sha256.convert(bytes);

    print('Digest as bytes: ${digest.bytes}');
    print('Digest as hex string: $digest');

    map['salt'] = salt;
    map['master'] = digest.toString();

    String updatedContent = jsonEncode(map);
    await master.writeAsString(updatedContent);
  }

  String masterPassword = '';
  print('Enter the master password: ');
  do {
    masterPassword = stdin.readLineSync() ?? '';
  } while (masterPassword.trim().isEmpty);

  final bytes = utf8.encode(masterPassword + map['salt']);
  final Digest digest = sha256.convert(bytes);

  if (digest.toString() == map['master']) {
    print('Access granted.');

    String option = '';

    print('1. Add a new password');
    print('2. Retrieve a password');

    do {
      option = stdin.readLineSync() ?? '';
    } while (option != '1' && option != '2');

    switch (option) {
      case '1':
        final File passwords = File('data/passwords.json');
        Map<String, dynamic> map = await readFile(passwords);

        String service = '';

        print('Enter the name of the service: ');
        do {
          service = stdin.readLineSync() ?? '';
        } while (service.trim().isEmpty);

        addPassword(map, service);

        String updatedContent = jsonEncode(map);
        await passwords.writeAsString(updatedContent);

        break;

      case '2':
        final File passwords = File('data/passwords.json');
        Map<String, dynamic> map = await readFile(passwords);

        String service = '';

        print('Enter the name of the service: ');
        do {
          service = stdin.readLineSync() ?? '';
        } while (service.trim().isEmpty);

        if (map.containsKey(service)) {
          print('Password: ${map[service]}');
        } else {
          print('Service not found.');
        }

        break;
    }
  } else {
    print('Access denied.');
  }
}

Future<Map<String, dynamic>> readFile(final File file) async {
  try {
    if (!await file.exists()) {
      print('File not found. Creating a new file...');
      await file.create(recursive: true);
      await file.writeAsString('{}');
    }

    String lines = await file.readAsString();
    if (lines.isEmpty) {
      print('File is empty. Writing default content...');
      await file.writeAsString('{}');
    }

    var map = jsonDecode(lines);

    if (map is! Map<String, dynamic>) {
      throw FormatException('The content of the file is not a map.');
    }

    return map;
  } catch (e) {
    print('Error reading the file: $e');
    await file.writeAsString('{}');
    return {};
  }
}

void addPassword(Map<String, dynamic> map, String service) {
  String answer = '';

  if (map.containsKey(service)) {
    print('This service already exists.');
    print(' Do you want to update the password? (y/n)');

    do {
      answer = stdin.readLineSync()?.toLowerCase() ?? '';
    } while (answer != 'y' && answer != 'n');

    if (answer == 'n') return;
  }

  String option = '';

  print('1. Generate a new password');
  print('2. Use an existing password');

  do {
    option = stdin.readLineSync() ?? '';
  } while (option != '1' && option != '2');

  String password = '';

  switch (option) {
    case '1':
      password = generatePassword();
      break;
    case '2':
      print('Enter the password: ');
      do {
        password = stdin.readLineSync() ?? '';
      } while (password.trim().isEmpty);
      break;
  }

  map[service] = password;
}
