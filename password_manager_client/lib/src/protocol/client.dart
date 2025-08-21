/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:password_manager_client/src/protocol/char_set.dart' as _i3;
import 'protocol.dart' as _i4;

/// Endpoint that exposes password generation functionality.
///
/// The endpoint produces cryptographically secure random passwords based on
/// the requested character sets and length. The generation uses
/// [Random.secure] to draw randomness from a secure source when available.
///
/// Note: callers should ensure that `charSets` is not empty and that `length`
/// is greater than zero. If these preconditions are not met, the method will
/// throw an error (see [generatePassword] documentation below).
/// {@category Endpoint}
class EndpointPasswordGenerator extends _i1.EndpointRef {
  EndpointPasswordGenerator(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'passwordGenerator';

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
  _i2.Future<String> generatePassword({
    required int length,
    required Set<_i3.CharSet> charSets,
    required bool excludeAmbiguous,
  }) =>
      caller.callServerEndpoint<String>(
        'passwordGenerator',
        'generatePassword',
        {
          'length': length,
          'charSets': charSets,
          'excludeAmbiguous': excludeAmbiguous,
        },
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    passwordGenerator = EndpointPasswordGenerator(this);
  }

  late final EndpointPasswordGenerator passwordGenerator;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup =>
      {'passwordGenerator': passwordGenerator};

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
