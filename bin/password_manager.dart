import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

import 'package:password_manager/hash_manager.dart';
import 'package:password_manager/json_reader.dart';
import 'package:password_manager/password_generator.dart';

Future<void> main() async {
  final File passwords = File('data/passwords.json');

  final MasterPasswordManager manager =
      MasterPasswordManager(await readJSONFile(passwords));

  await passwords.writeAsString(jsonEncode(manager.map));

  final PBKDF2KeyDerivator pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
    ..init(Pbkdf2Parameters(base64.decode(manager.salt), 100000, 32));
  final key = pbkdf2.process(utf8.encode(manager.plain));

  final Encrypter encrypter = Encrypter(AES(Key(key), mode: AESMode.cbc));

  String option = '';

  print('1. Add a new password');
  print('2. Retrieve a password');

  do {
    option = stdin.readLineSync() ?? '';
  } while (option != '1' && option != '2');

  String service = '';

  print('Enter the name of the service: ');
  do {
    service = stdin.readLineSync() ?? '';
  } while (service.trim().isEmpty);

  switch (option) {
    case '1':
      addPassword(manager.passwords, service, encrypter);
      await passwords.writeAsString(jsonEncode(manager.map));
      break;

    case '2':
      if (manager.passwords.containsKey(service)) {
        final Encrypted password =
            Encrypted.fromBase64(manager.passwords[service]['password']);
        final IV iv = IV.fromBase64(manager.passwords[service]['iv']);

        print('Password: ${encrypter.decrypt(password, iv: iv)}');
      } else {
        print('Service not found.');
      }

      break;
  }
}

/*  */

/// A class that manages the master password by extending the HashManager.
/// It handles user authentication and stores a collection of service passwords.
class MasterPasswordManager extends HashManager {
  /// A map to store passwords for various services.
  Map<String, dynamic> passwords = {};

  /// The plaintext master password entered by the user.
  late String plain;

  /// Constructor for MasterPasswordManager.
  ///
  /// It accepts a [map] which is expected to contain the keys 'salt',
  /// 'master', and 'passwords'. The salt from the map is used to initialize
  /// the superclass HashManager. The constructor then prompts the user to
  /// enter the master password until a valid, non-empty input is provided.
  /// If the map is valid, it assigns the stored passwords and validates the
  /// entered password by comparing its hash to the stored master hash.
  MasterPasswordManager(final Map<String, dynamic> map)
      : super(salt: map['salt']) {
    // Prompt for the master password until a non-empty value is entered.
    do {
      print('Enter the master password: ');
      plain = stdin.readLineSync() ?? '';
    } while (plain.trim().isEmpty);

    // If the map is valid (contains required keys), proceed with authentication.
    if (_isValidMap(map)) {
      // Assign the stored passwords from the map.
      passwords = map['passwords'];

      // Continue prompting until the entered password's hash matches the stored master hash.
      while (hash(plain) != map['master']) {
        print('Enter the master password: ');
        plain = stdin.readLineSync() ?? '';
      }
    }
  }

  /// Returns a map representation of the current master password configuration,
  /// including the salt, the hashed master password, and the service passwords.
  Map<String, dynamic> get map =>
      {'salt': salt, 'master': hash(plain), 'passwords': passwords};

  /// Checks if the provided [map] is valid by ensuring it contains the keys:
  /// 'salt', 'master', and 'passwords', and that 'passwords' is a Map.
  bool _isValidMap(final Map<String, dynamic> map) =>
      map.containsKey('salt') &&
      map.containsKey('master') &&
      map.containsKey('passwords') &&
      map['passwords'] is Map<String, dynamic>;
}

/*  */

void addPassword(Map passwords, String service, Encrypter encrypter) {
  String answer = '';

  if (passwords.containsKey(service)) {
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

  passwords[service] = {
    'iv': iv.base64,
    'password': encrypter.encrypt(password, iv: iv).base64
  };
}
