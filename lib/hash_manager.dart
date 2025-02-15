import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// A class responsible for generating a salt and computing a SHA-256 hash
/// for a given plaintext concatenated with that salt.
class HashManager {
  /// The salt used in the hashing process.
  /// If no salt is provided, a new one is generated.
  final String salt;

  /// Constructor for HashManager.
  ///
  /// [salt]: Optional salt value. If not provided, a new salt is generated using [_generateSalt()].
  HashManager({final String? salt}) : salt = salt ?? _generateSalt();

  /// Computes the SHA-256 hash of the given [plain] text concatenated with the salt.
  ///
  /// [plain]: The plaintext to be hashed.
  /// Returns the hexadecimal string representation of the hash.
  String hash(final String plain) {
    // Convert the concatenated string (plain text + salt) into bytes.
    final bytes = utf8.encode(plain + salt);
    // Compute the SHA-256 digest of the bytes.
    final Digest digest = sha256.convert(bytes);
    // Return the digest as a hexadecimal string.
    return digest.toString();
  }

  /// Generates a cryptographically secure random salt.
  ///
  /// Returns a Base64-encoded string representing the generated salt.
  static String _generateSalt() {
    // Use Random.secure() to generate a secure random number generator.
    final Random random = Random.secure();
    // Generate a list of 16 random bytes.
    final List<int> saltBytes =
        List<int>.generate(16, (_) => random.nextInt(256));
    // Encode the byte list into a Base64 string.
    return base64.encode(saltBytes);
  }
}
