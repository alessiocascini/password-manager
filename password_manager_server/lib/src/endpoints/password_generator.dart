import 'dart:math';

import 'package:password_manager_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint that exposes password generation functionality.
///
/// The endpoint produces cryptographically secure random passwords based on
/// the requested character sets and length. The generation uses
/// [Random.secure] to draw randomness from a secure source when available.
///
/// Note: callers should ensure that `charSets` is not empty and that `length`
/// is greater than zero. If these preconditions are not met, the method will
/// throw an error (see [generatePassword] documentation below).
class PasswordGeneratorEndpoint extends Endpoint {
  /// Mapping from character set identifier ([CharSet]) to the string of
  /// characters that belong to that set.
  ///
  /// Keep this `private` and `const` so the character sets are colocated with
  /// the generator but cannot be modified at runtime.
  static const Map<CharSet, String> _sets = {
    CharSet.uppercase: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    CharSet.lowercase: 'abcdefghijklmnopqrstuvwxyz',
    CharSet.numbers: '0123456789',
    CharSet.special: '!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~',
  };

  /// Regular expression that matches characters considered "ambiguous"
  /// (for example: `l`, `o`, `0`, `1`). This is used to optionally remove
  /// those characters from the chosen character groups when
  /// [excludeAmbiguous] is true.
  static final RegExp _ambiguousRegex = RegExp(r'[lo01]');

  /// Generates a random password.
  ///
  /// Parameters:
  /// - [session]: Serverpod session/context for the request (passed
  ///   automatically when called from the generated client).
  /// - [length]: Desired length of the resulting password. Must be > 0.
  /// - [charSets]: A non-empty set of [CharSet] values that specify which
  ///   character groups should be included in the generation. The generator
  ///   guarantees at least one character from each selected group will appear
  ///   in the result when possible (i.e. when [length] is >= number of
  ///   selected groups).
  /// - [excludeAmbiguous]: If true, ambiguous characters (see
  ///   [_ambiguousRegex]) are removed from the chosen character groups. This
  ///   defaults to `true` because ambiguous characters are commonly omitted to
  ///   improve readability.
  ///
  /// Returns: a randomly generated password as a [String].
  ///
  /// Throws:
  /// - [ArgumentError] if [length] is not greater than zero.
  /// - [RangeError] or [StateError] may occur indirectly if [charSets] is
  ///   empty or if the pool of available characters becomes empty after
  ///   applying [excludeAmbiguous]. Callers should ensure [charSets] is valid
  ///   to avoid runtime errors.
  Future<String> generatePassword(
    Session session, {
    required final int length,
    required final Set<CharSet> charSets,
    final bool excludeAmbiguous = true,
  }) async {
    if (length <= 0) {
      throw ArgumentError.value(length, 'length', 'Length must be > 0');
    }

    // Build the list of character groups according to the requested options.
    final List<String> groups = charSets.map((cs) {
      final String group = _sets[cs]!;
      return excludeAmbiguous ? group.replaceAll(_ambiguousRegex, '') : group;
    }).toList();

    // Note: If `groups` is empty (e.g. caller passed an empty `charSets`),
    // subsequent code may throw due to selecting a random index from an
    // empty pool. That is intentional; callers should validate inputs.

    final Random rng = Random.secure();

    // Generate `length` characters. To ensure at least one character from
    // each selected group is present when possible, we pick one character from
    // each group for the first `groups.length` positions, then fill the rest
    // from the full concatenated pool.
    final List<String> passwordChars = List.generate(length, (final int i) {
      final String pool = i < groups.length ? groups[i] : groups.join('');
      return pool[rng.nextInt(pool.length)];
    });

    // Shuffle to remove any positional predictability, then join into a
    // single string result.
    passwordChars.shuffle(rng);
    return passwordChars.join('');
  }
}
