import 'dart:math';

import 'package:password_manager_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PasswordGeneratorEndpoint extends Endpoint {
  static const Map<CharSet, String> _sets = {
    CharSet.uppercase: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    CharSet.lowercase: 'abcdefghijklmnopqrstuvwxyz',
    CharSet.numbers: '0123456789',
    CharSet.special: '!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~',
  };

  static final RegExp _ambiguousRegex = RegExp(r'[lo01]');

  Future<String> generatePassword(
    Session session, {
    required final int length,
    required final Set<CharSet> charSets,
    final bool excludeAmbiguous = true,
  }) async {
    if (length <= 0) {
      throw ArgumentError.value(length, 'length', 'Length must be > 0');
    }

    final List<String> groups = charSets.map((cs) {
      final String group = _sets[cs]!;
      return excludeAmbiguous ? group.replaceAll(_ambiguousRegex, '') : group;
    }).toList();

    final Random rng = Random.secure();
    final List<String> passwordChars = List.generate(length, (final int i) {
      final String pool = i < groups.length ? groups[i] : groups.join('');
      return pool[rng.nextInt(pool.length)];
    });

    passwordChars.shuffle(rng);
    return passwordChars.join('');
  }
}
