/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'password.dart' as _i2;

abstract class User implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = UserTable();

  static const db = UserRepository._();

  @override
  int? id;

  String username;

  String salt;

  String master;

  List<_i2.Password>? passwords;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'username': username,
      'salt': salt,
      'master': master,
      if (passwords != null)
        'passwords':
            passwords?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static UserInclude include({_i2.PasswordIncludeList? passwords}) {
    return UserInclude._(passwords: passwords);
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
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

class UserTable extends _i1.Table<int?> {
  UserTable({super.tableRelation}) : super(tableName: 'user') {
    username = _i1.ColumnString(
      'username',
      this,
    );
    salt = _i1.ColumnString(
      'salt',
      this,
    );
    master = _i1.ColumnString(
      'master',
      this,
    );
  }

  late final _i1.ColumnString username;

  late final _i1.ColumnString salt;

  late final _i1.ColumnString master;

  _i2.PasswordTable? ___passwords;

  _i1.ManyRelation<_i2.PasswordTable>? _passwords;

  _i2.PasswordTable get __passwords {
    if (___passwords != null) return ___passwords!;
    ___passwords = _i1.createRelationTable(
      relationFieldName: '__passwords',
      field: User.t.id,
      foreignField: _i2.Password.t.$_userPasswordsUserId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PasswordTable(tableRelation: foreignTableRelation),
    );
    return ___passwords!;
  }

  _i1.ManyRelation<_i2.PasswordTable> get passwords {
    if (_passwords != null) return _passwords!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'passwords',
      field: User.t.id,
      foreignField: _i2.Password.t.$_userPasswordsUserId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PasswordTable(tableRelation: foreignTableRelation),
    );
    _passwords = _i1.ManyRelation<_i2.PasswordTable>(
      tableWithRelations: relationTable,
      table: _i2.PasswordTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _passwords!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        username,
        salt,
        master,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'passwords') {
      return __passwords;
    }
    return null;
  }
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._({_i2.PasswordIncludeList? passwords}) {
    _passwords = passwords;
  }

  _i2.PasswordIncludeList? _passwords;

  @override
  Map<String, _i1.Include?> get includes => {'passwords': _passwords};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserRepository {
  const UserRepository._();

  final attach = const UserAttachRepository._();

  final attachRow = const UserAttachRowRepository._();

  final detach = const UserDetachRepository._();

  final detachRow = const UserDetachRowRepository._();

  /// Returns a list of [User]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<User>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [User] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<User?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [User] by its [id] or null if no such row exists.
  Future<User?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [User]s in the list and returns the inserted rows.
  ///
  /// The returned [User]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<User>> insert(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [User] and returns the inserted row.
  ///
  /// The returned [User] will have its `id` field set.
  Future<User> insertRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [User]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<User>> update(
    _i1.Session session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<User> updateRow(
    _i1.Session session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Deletes all [User]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<User>> delete(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [User].
  Future<User> deleteRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<User>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserAttachRepository {
  const UserAttachRepository._();

  /// Creates a relation between this [User] and the given [Password]s
  /// by setting each [Password]'s foreign key `_userPasswordsUserId` to refer to this [User].
  Future<void> passwords(
    _i1.Session session,
    User user,
    List<_i2.Password> password, {
    _i1.Transaction? transaction,
  }) async {
    if (password.any((e) => e.id == null)) {
      throw ArgumentError.notNull('password.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $password = password
        .map((e) => _i2.PasswordImplicit(
              e,
              $_userPasswordsUserId: user.id,
            ))
        .toList();
    await session.db.update<_i2.Password>(
      $password,
      columns: [_i2.Password.t.$_userPasswordsUserId],
      transaction: transaction,
    );
  }
}

class UserAttachRowRepository {
  const UserAttachRowRepository._();

  /// Creates a relation between this [User] and the given [Password]
  /// by setting the [Password]'s foreign key `_userPasswordsUserId` to refer to this [User].
  Future<void> passwords(
    _i1.Session session,
    User user,
    _i2.Password password, {
    _i1.Transaction? transaction,
  }) async {
    if (password.id == null) {
      throw ArgumentError.notNull('password.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $password = _i2.PasswordImplicit(
      password,
      $_userPasswordsUserId: user.id,
    );
    await session.db.updateRow<_i2.Password>(
      $password,
      columns: [_i2.Password.t.$_userPasswordsUserId],
      transaction: transaction,
    );
  }
}

class UserDetachRepository {
  const UserDetachRepository._();

  /// Detaches the relation between this [User] and the given [Password]
  /// by setting the [Password]'s foreign key `_userPasswordsUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> passwords(
    _i1.Session session,
    List<_i2.Password> password, {
    _i1.Transaction? transaction,
  }) async {
    if (password.any((e) => e.id == null)) {
      throw ArgumentError.notNull('password.id');
    }

    var $password = password
        .map((e) => _i2.PasswordImplicit(
              e,
              $_userPasswordsUserId: null,
            ))
        .toList();
    await session.db.update<_i2.Password>(
      $password,
      columns: [_i2.Password.t.$_userPasswordsUserId],
      transaction: transaction,
    );
  }
}

class UserDetachRowRepository {
  const UserDetachRowRepository._();

  /// Detaches the relation between this [User] and the given [Password]
  /// by setting the [Password]'s foreign key `_userPasswordsUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> passwords(
    _i1.Session session,
    _i2.Password password, {
    _i1.Transaction? transaction,
  }) async {
    if (password.id == null) {
      throw ArgumentError.notNull('password.id');
    }

    var $password = _i2.PasswordImplicit(
      password,
      $_userPasswordsUserId: null,
    );
    await session.db.updateRow<_i2.Password>(
      $password,
      columns: [_i2.Password.t.$_userPasswordsUserId],
      transaction: transaction,
    );
  }
}
