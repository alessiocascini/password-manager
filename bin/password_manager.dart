import 'dart:convert';
import 'dart:io';

import 'package:password_manager/cryptography_manager.dart';
import 'package:password_manager/hash_manager.dart';
import 'package:password_manager/json_reader.dart';
import 'package:password_manager/password_generator.dart';

/// Prompts the user for an option and validates the input.
///
/// If [options] is provided, the input must match one of the values in [options].
/// The function will continue prompting until a valid input is provided.
String askUserOption({List<String>? options}) {
  String option = '';

  do {
    option = stdin.readLineSync()?.trim() ?? '';
  } while (options != null ? !options.contains(option) : option.isEmpty);
  return option;
}

/// Entry point for the password manager application.
///
/// This function reads the stored password data from a JSON file,
/// initializes the MasterPasswordManager, and processes user input
/// to add or retrieve a password. Finally, it writes the updated data back to the file.
Future<void> main() async {
  // Define the file where passwords are stored.
  final File passwordsFile = File('data/passwords.json');

  // Initialize the MasterPasswordManager using the JSON data from the file.
  final MasterPasswordManager manager =
      MasterPasswordManager(await readJSONFile(passwordsFile));

  try {
    // Create an instance of CryptographyManager using the salt and master password.
    final CryptographyManager encrypter =
        CryptographyManager(base64.decode(manager.salt), manager.plain);

    // Display menu options for the user.
    print('1. Add a new password');
    print('2. Retrieve a password');

    // Prompt the user to choose an action.
    String action = askUserOption(options: ['1', '2']);

    // Prompt the user to enter the name of the service.
    print('Enter the name of the service: ');
    String service = askUserOption();

    // Execute the chosen action.
    if (action == '1') {
      // Add a new password for the specified service.
      manager.addPassword(service, encrypter);
    } else if (manager.passwords.containsKey(service)) {
      // Retrieve and decrypt the password for the specified service.
      print('Password: ${encrypter.decrypt(manager.passwords[service])}');
    } else {
      // Inform the user if the service does not exist.
      print('The service does not exist.');
    }
  } catch (e) {
    // Handle any errors that occur during execution.
    print('An error occurred: $e');
  }

  // Write the updated password data back to the JSON file.
  await passwordsFile.writeAsString(jsonEncode(manager.map));
}

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
  /// the superclass HashManager. The constructor then uses [askUserOption]
  /// to prompt the user for the master password until a valid, non-empty input is provided.
  /// If the map is valid, it assigns the stored passwords and validates the entered
  /// password by comparing its hash to the stored master hash.
  MasterPasswordManager(final Map<String, dynamic> map)
      : super(salt: map['salt']) {
    // Prompt the user for the master password using askUserOption.
    print('Enter the master password: ');
    plain = askUserOption();

    // If the map is valid (contains required keys), proceed with authentication.
    if (_isValidMap(map)) {
      // Assign the stored passwords from the map.
      passwords = map['passwords'];

      // Continue prompting until the entered password's hash matches the stored master hash.
      while (hash(plain) != map['master']) {
        print('Enter the master password: ');
        plain = askUserOption();
      }
    }
  }

  /// Returns a map representation of the current master password configuration,
  /// including the salt, the hashed master password, and the service passwords.
  Map<String, dynamic> get map =>
      {'salt': salt, 'master': hash(plain), 'passwords': passwords};

  /// Adds or updates a password for the given [service].
  ///
  /// If the service already exists, prompts the user for confirmation to update.
  /// The user can choose to generate a new password or use an existing one.
  /// The selected password is then encrypted using [encrypter] and stored.
  void addPassword(final String service, final CryptographyManager encrypter) {
    if (passwords.containsKey(service)) {
      print('This service already exists.');
      print('Do you want to update the password? (y/n): ');

      if (askUserOption(options: ['y', 'n']) == 'n') return;
    }

    print('1. Generate a new password');
    print('2. Use an existing password');

    // Choose between generating a new password or inputting an existing one.
    final String password = askUserOption(options: ['1', '2']) == '1'
        ? PasswordGenerator().password
        : _getPassword();

    // Encrypt and store the password for the specified service.
    passwords[service] = encrypter.encrypt(password);
  }

  /// Checks if the provided [map] is valid.
  ///
  /// A valid map must contain the keys 'salt', 'master', and 'passwords',
  /// and 'passwords' must be a [Map<String, dynamic>].
  bool _isValidMap(final Map<String, dynamic> map) =>
      map.containsKey('salt') &&
      map.containsKey('master') &&
      map.containsKey('passwords') &&
      map['passwords'] is Map<String, dynamic>;

  /// Prompts the user to enter a password.
  ///
  /// Displays a prompt message and returns the password entered by the user.
  String _getPassword() {
    print('Enter the password: ');
    return askUserOption();
  }
}
