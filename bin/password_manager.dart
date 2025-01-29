import 'dart:io';
import 'dart:convert';
import 'package:password_manager/password_generator.dart';

Future<void> main() async {
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

    String service = '';

    print('Enter the name of the service: ');
    do {
      service = stdin.readLineSync() ?? '';
    } while (service.trim().isEmpty);

    addPassword(map, service);

    String updatedContent = jsonEncode(map);
    await passwords.writeAsString(updatedContent);
  } catch (e) {
    print(e);
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
