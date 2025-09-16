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
import 'password.dart' as _i2;

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.username,
    required this.salt,
    required this.master,
    this.passwords,
  });

  factory User({
    int? id,
    required String username,
    required String salt,
    required String master,
    List<_i2.Password>? passwords,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      username: jsonSerialization['username'] as String,
      salt: jsonSerialization['salt'] as String,
      master: jsonSerialization['master'] as String,
      passwords: (jsonSerialization['passwords'] as List?)
          ?.map((e) => _i2.Password.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String username;

  String salt;

  String master;

  List<_i2.Password>? passwords;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? username,
    String? salt,
    String? master,
    List<_i2.Password>? passwords,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'username': username,
      'salt': salt,
      'master': master,
      if (passwords != null)
        'passwords': passwords?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String username,
    required String salt,
    required String master,
    List<_i2.Password>? passwords,
  }) : super._(
          id: id,
          username: username,
          salt: salt,
          master: master,
          passwords: passwords,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? username,
    String? salt,
    String? master,
    Object? passwords = _Undefined,
  }) {
    return User(
      id: id is int? ? id : this.id,
      username: username ?? this.username,
      salt: salt ?? this.salt,
      master: master ?? this.master,
      passwords: passwords is List<_i2.Password>?
          ? passwords
          : this.passwords?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
