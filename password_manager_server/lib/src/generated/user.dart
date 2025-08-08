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

abstract class User
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  User._({
    required this.salt,
    required this.master,
  });

  factory User({
    required String salt,
    required String master,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      salt: jsonSerialization['salt'] as String,
      master: jsonSerialization['master'] as String,
    );
  }

  String salt;

  String master;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    String? salt,
    String? master,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'salt': salt,
      'master': master,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'salt': salt,
      'master': master,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserImpl extends User {
  _UserImpl({
    required String salt,
    required String master,
  }) : super._(
          salt: salt,
          master: master,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    String? salt,
    String? master,
  }) {
    return User(
      salt: salt ?? this.salt,
      master: master ?? this.master,
    );
  }
}
