import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';
import 'package:password_manager/password_generator.dart';
import 'package:password_manager/json_reader.dart';

Future<void> main() async {
  final File passwords = File('data/passwords.json');
  Map<String, dynamic> map = await readJSONFile(passwords);

  try {
    await createMasterPassword(passwords, map);
  } catch (e) {
    print('Error creating the master password: $e');
    return;
  }

  String masterPassword = '';
  print('Enter the master password: ');
  do {
    masterPassword = stdin.readLineSync() ?? '';
  } while (masterPassword.trim().isEmpty);

  final bytes = utf8.encode(masterPassword + map['salt']);
  final digest = sha256.convert(bytes);

  if (digest.toString() == map['master']) {
    print('Access granted.');

    String option = '';

    print('1. Add a new password');
    print('2. Retrieve a password');

    do {
      option = stdin.readLineSync() ?? '';
    } while (option != '1' && option != '2');

    final PBKDF2KeyDerivator pbkdf2 =
        PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
          ..init(Pbkdf2Parameters(base64.decode(map['salt']), 100000, 32));
    final key = pbkdf2.process(utf8.encode(masterPassword));

    final Encrypter encrypter = Encrypter(AES(Key(key), mode: AESMode.cbc));

    switch (option) {
      case '1':
        String service = '';

        print('Enter the name of the service: ');
        do {
          service = stdin.readLineSync() ?? '';
        } while (service.trim().isEmpty);

        addPassword(map['passwords'], service, encrypter);

        String updatedContent = jsonEncode(map);
        await passwords.writeAsString(updatedContent);

        break;

      case '2':
        String service = '';

        print('Enter the name of the service: ');
        do {
          service = stdin.readLineSync() ?? '';
        } while (service.trim().isEmpty);

        if (map['passwords'].containsKey(service)) {
          print(
              'Password: ${encrypter.decrypt(Encrypted.fromBase64(map['passwords'][service]['password']), iv: IV.fromBase64(map['passwords'][service]['iv']))}');
        } else {
          print('Service not found.');
        }

        break;
    }
  } else {
    print('Access denied.');
  }
}

void addPassword(Map map, String service, Encrypter encrypter) {
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
      password = PasswordGenerator().password;
      break;
    case '2':
      print('Enter the password: ');
      do {
        password = stdin.readLineSync() ?? '';
      } while (password.trim().isEmpty);
      break;
  }

  final IV iv = IV.fromSecureRandom(16);

  map[service] = {
    'iv': iv.base64,
    'password': encrypter.encrypt(password, iv: iv).base64
  };
}

Future<void> createMasterPassword(
    File passwords, Map<String, dynamic> map) async {
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
    final digest = sha256.convert(bytes);

    print('Digest as bytes: ${digest.bytes}');
    print('Digest as hex string: $digest');

    map['salt'] = salt;
    map['master'] = digest.toString();
    map['passwords'] = {};

    String updatedContent = jsonEncode(map);
    await passwords.writeAsString(updatedContent);
  } else {
    if (!map.containsKey('salt') ||
        !map.containsKey('master') ||
        !map.containsKey('passwords')) {
      throw FormatException('The content of the file is not valid.');
    }

    if (map['passwords'] is! Map<String, dynamic>) {
      throw FormatException('The content of the file is not a map.');
    }
  }
}
