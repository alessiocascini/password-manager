import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Utility class that provides helpers for generating a cryptographically
/// secure random salt and computing a SHA-256 digest for a given plaintext
/// concatenated with that salt.
///
/// **Important security note:** SHA-256 is a fast cryptographic hash and **is
/// not suitable** by itself for hashing user passwords (it is susceptible to
/// brute-force attacks). For password storage prefer a slow, memory-hard
/// algorithm such as Argon2, bcrypt or scrypt (or use a KDF like PBKDF2 with
/// appropriate parameters). Use the `hash` method below only for non-password
/// hashing purposes (e.g. integrity checks, keyed HMAC inputs when combined
/// with a secret, or as part of a stronger KDF).
class HashManager {
  // Private constructor to prevent instantiation — this class exposes only
  // static helper methods and should not be constructed.
  HashManager._();

  /// Computes the SHA-256 hash of the concatenation of [plain] and [salt].
  ///
  /// [plain]: The input plaintext to be hashed.
  /// [salt]:  A salt value (typically random) that is appended to the
  ///          plaintext before hashing to provide uniqueness.
  ///
  /// Returns the hexadecimal representation of the SHA-256 digest.
  ///
  /// Note: This method is synchronous and returns a string suitable for
  /// storage or comparison. For password storage, prefer a dedicated
  /// password-hashing function (Argon2 / bcrypt / scrypt) rather than a raw
  /// SHA-256 digest.
  static String hash({
    required final String plain,
    required final String salt,
  }) {
    // Convert the concatenated plaintext + salt into bytes using UTF-8.
    final List<int> bytes = utf8.encode(plain + salt);

    // Compute the SHA-256 digest.
    final Digest digest = sha256.convert(bytes);

    // Return the digest encoded as a lowercase hexadecimal string.
    return digest.toString();
  }

  /// Generates a cryptographically secure random salt and returns it as a
  /// Base64-encoded string.
  ///
  /// The default length is 16 bytes (128 bits) which is suitable for most
  /// use cases; increase the size (for example to 32 bytes) if you require
  /// more entropy.
  ///
  /// Implementation notes:
  /// - Uses [Random.secure()] as the source of randomness where available.
  /// - The returned salt is safe to store in the database alongside the
  ///   hashed value; salts do not need to be secret, they only need to be
  ///   unique per user/record.
  static String generateSalt() {
    final Random random = Random.secure();
    final List<int> saltBytes =
        List<int>.generate(16, (_) => random.nextInt(256));
    return base64.encode(saltBytes);
  }
}
