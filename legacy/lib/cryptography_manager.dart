import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

/// A manager class for cryptographic operations such as encryption and decryption.
/// It derives a symmetric key using PBKDF2 and uses AES in CBC mode for the operations.
class CryptographyManager {
  // The Encrypter instance used for performing AES encryption/decryption.
  late final Encrypter _encrypter;

  /// Constructs a [CryptographyManager] by deriving a key from the provided [salt] and [plain] text.
  ///
  /// Throws an [ArgumentError] if the provided [salt] is shorter than 16 bytes.
  ///
  /// [salt]: A cryptographically secure salt as a [Uint8List].
  /// [plain]: The plaintext (e.g., master password) used for key derivation.
  CryptographyManager(final Uint8List salt, final String plain) {
    // Validate that the salt length is at least 16 bytes.
    if (salt.length < 16) throw ArgumentError('Invalid salt.');

    // Initialize the PBKDF2 key derivator with HMAC-SHA256.
    final PBKDF2KeyDerivator pbkdf2 = PBKDF2KeyDerivator(
        HMac(SHA256Digest(), 64))
      // Set the parameters: salt, 100000 iterations, and a desired key length of 32 bytes.
      ..init(Pbkdf2Parameters(salt, 100000, 32));

    // Derive the key by processing the UTF-8 encoded plain text.
    final Uint8List key = pbkdf2.process(utf8.encode(plain));

    // Initialize the Encrypter with the derived key using AES in CBC mode.
    _encrypter = Encrypter(AES(Key(key), mode: AESMode.cbc));
  }

  /// Encrypts the provided [data] string.
  ///
  /// Generates a random IV (Initialization Vector) for each encryption operation.
  /// Returns a [Map<String, String>] containing the Base64-encoded IV and encrypted data.
  Map<String, String> encrypt(final String data) {
    // Generate a secure random IV of 16 bytes.
    final IV iv = IV.fromSecureRandom(16);
    // Encrypt the data using the encrypter and the generated IV.
    final Encrypted encrypted = _encrypter.encrypt(data, iv: iv);

    // Return the IV and encrypted data as Base64 encoded strings.
    return {'iv': iv.base64, 'data': encrypted.base64};
  }

  /// Decrypts the provided data map containing the 'iv' and 'data' keys.
  ///
  /// Throws an [ArgumentError] if the required keys are missing in the [data] map.
  ///
  /// [data]: A map containing the Base64-encoded 'iv' and 'data' (encrypted text).
  /// Returns the decrypted plaintext string.
  String decrypt(final Map<String, dynamic> data) {
    // Ensure that the data map contains both 'iv' and 'data' keys.
    if (!data.containsKey('iv') || !data.containsKey('data')) {
      throw ArgumentError('Invalid data.');
    }

    // Decode the IV and the encrypted data from their Base64 representations.
    final IV iv = IV.fromBase64(data['iv']);
    final Encrypted encrypted = Encrypted.fromBase64(data['data']);

    // Decrypt the data using the stored encrypter and the IV.
    return _encrypter.decrypt(encrypted, iv: iv);
  }
}
