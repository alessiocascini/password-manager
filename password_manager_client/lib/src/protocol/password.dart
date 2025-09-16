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

abstract class Password implements _i1.SerializableModel {
  Password._({
    this.id,
    required this.service,
    required this.iv,
    required this.password,
  });

  factory Password({
    int? id,
    required String service,
    required String iv,
    required String password,
  }) = _PasswordImpl;

  factory Password.fromJson(Map<String, dynamic> jsonSerialization) {
    return Password(
      id: jsonSerialization['id'] as int?,
      service: jsonSerialization['service'] as String,
      iv: jsonSerialization['iv'] as String,
      password: jsonSerialization['password'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String service;

  String iv;

  String password;

  /// Returns a shallow copy of this [Password]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Password copyWith({
    int? id,
    String? service,
    String? iv,
    String? password,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
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

class _Undefined {}

class _PasswordImpl extends Password {
  _PasswordImpl({
    int? id,
    required String service,
    required String iv,
    required String password,
  }) : super._(
          id: id,
          service: service,
          iv: iv,
          password: password,
        );

  /// Returns a shallow copy of this [Password]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Password copyWith({
    Object? id = _Undefined,
    String? service,
    String? iv,
    String? password,
  }) {
    return Password(
      id: id is int? ? id : this.id,
      service: service ?? this.service,
      iv: iv ?? this.iv,
      password: password ?? this.password,
    );
  }
}
