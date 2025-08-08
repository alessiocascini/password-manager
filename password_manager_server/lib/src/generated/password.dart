/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Password
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Password._({
    required this.service,
    required this.iv,
    required this.password,
  });

  factory Password({
    required String service,
    required String iv,
    required String password,
  }) = _PasswordImpl;

  factory Password.fromJson(Map<String, dynamic> jsonSerialization) {
    return Password(
      service: jsonSerialization['service'] as String,
      iv: jsonSerialization['iv'] as String,
      password: jsonSerialization['password'] as String,
    );
  }

  String service;

  String iv;

  String password;

  /// Returns a shallow copy of this [Password]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Password copyWith({
    String? service,
    String? iv,
    String? password,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'iv': iv,
      'password': password,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'service': service,
      'iv': iv,
      'password': password,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PasswordImpl extends Password {
  _PasswordImpl({
    required String service,
    required String iv,
    required String password,
  }) : super._(
          service: service,
          iv: iv,
          password: password,
        );

  /// Returns a shallow copy of this [Password]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Password copyWith({
    String? service,
    String? iv,
    String? password,
  }) {
    return Password(
      service: service ?? this.service,
      iv: iv ?? this.iv,
      password: password ?? this.password,
    );
  }
}
