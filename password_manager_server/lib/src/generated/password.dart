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
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Password._({
    this.id,
    required this.iv,
    required this.service,
    required this.password,
  }) : _userPasswordsUserId = null;

  factory Password({
    int? id,
    required String iv,
    required String service,
    required String password,
  }) = _PasswordImpl;

  factory Password.fromJson(Map<String, dynamic> jsonSerialization) {
    return PasswordImplicit._(
      id: jsonSerialization['id'] as int?,
      iv: jsonSerialization['iv'] as String,
      service: jsonSerialization['service'] as String,
      password: jsonSerialization['password'] as String,
      $_userPasswordsUserId: jsonSerialization['_userPasswordsUserId'] as int?,
    );
  }

  static final t = PasswordTable();

  static const db = PasswordRepository._();

  @override
  int? id;

  String iv;

  String service;

  String password;

  final int? _userPasswordsUserId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Password]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Password copyWith({
    int? id,
    String? iv,
    String? service,
    String? password,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'iv': iv,
      'service': service,
      'password': password,
      if (_userPasswordsUserId != null)
        '_userPasswordsUserId': _userPasswordsUserId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'iv': iv,
      'service': service,
      'password': password,
    };
  }

  static PasswordInclude include() {
    return PasswordInclude._();
  }

  static PasswordIncludeList includeList({
    _i1.WhereExpressionBuilder<PasswordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PasswordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasswordTable>? orderByList,
    PasswordInclude? include,
  }) {
    return PasswordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Password.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Password.t),
      include: include,
    );
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
    required String iv,
    required String service,
    required String password,
  }) : super._(
          id: id,
          iv: iv,
          service: service,
          password: password,
        );

  /// Returns a shallow copy of this [Password]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Password copyWith({
    Object? id = _Undefined,
    String? iv,
    String? service,
    String? password,
  }) {
    return PasswordImplicit._(
      id: id is int? ? id : this.id,
      iv: iv ?? this.iv,
      service: service ?? this.service,
      password: password ?? this.password,
      $_userPasswordsUserId: this._userPasswordsUserId,
    );
  }
}

class PasswordImplicit extends _PasswordImpl {
  PasswordImplicit._({
    int? id,
    required String iv,
    required String service,
    required String password,
    int? $_userPasswordsUserId,
  })  : _userPasswordsUserId = $_userPasswordsUserId,
        super(
          id: id,
          iv: iv,
          service: service,
          password: password,
        );

  factory PasswordImplicit(
    Password password, {
    int? $_userPasswordsUserId,
  }) {
    return PasswordImplicit._(
      id: password.id,
      iv: password.iv,
      service: password.service,
      password: password.password,
      $_userPasswordsUserId: $_userPasswordsUserId,
    );
  }

  @override
  final int? _userPasswordsUserId;
}

class PasswordTable extends _i1.Table<int?> {
  PasswordTable({super.tableRelation}) : super(tableName: 'password') {
    iv = _i1.ColumnString(
      'iv',
      this,
    );
    service = _i1.ColumnString(
      'service',
      this,
    );
    password = _i1.ColumnString(
      'password',
      this,
    );
    $_userPasswordsUserId = _i1.ColumnInt(
      '_userPasswordsUserId',
      this,
    );
  }

  late final _i1.ColumnString iv;

  late final _i1.ColumnString service;

  late final _i1.ColumnString password;

  late final _i1.ColumnInt $_userPasswordsUserId;

  @override
  List<_i1.Column> get columns => [
        id,
        iv,
        service,
        password,
        $_userPasswordsUserId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        iv,
        service,
        password,
      ];
}

class PasswordInclude extends _i1.IncludeObject {
  PasswordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Password.t;
}

class PasswordIncludeList extends _i1.IncludeList {
  PasswordIncludeList._({
    _i1.WhereExpressionBuilder<PasswordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Password.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Password.t;
}

class PasswordRepository {
  const PasswordRepository._();

  /// Returns a list of [Password]s matching the given query parameters.
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
  Future<List<Password>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasswordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PasswordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasswordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Password>(
      where: where?.call(Password.t),
      orderBy: orderBy?.call(Password.t),
      orderByList: orderByList?.call(Password.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Password] matching the given query parameters.
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
  Future<Password?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasswordTable>? where,
    int? offset,
    _i1.OrderByBuilder<PasswordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PasswordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Password>(
      where: where?.call(Password.t),
      orderBy: orderBy?.call(Password.t),
      orderByList: orderByList?.call(Password.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Password] by its [id] or null if no such row exists.
  Future<Password?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Password>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Password]s in the list and returns the inserted rows.
  ///
  /// The returned [Password]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Password>> insert(
    _i1.Session session,
    List<Password> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Password>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Password] and returns the inserted row.
  ///
  /// The returned [Password] will have its `id` field set.
  Future<Password> insertRow(
    _i1.Session session,
    Password row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Password>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Password]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Password>> update(
    _i1.Session session,
    List<Password> rows, {
    _i1.ColumnSelections<PasswordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Password>(
      rows,
      columns: columns?.call(Password.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Password]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Password> updateRow(
    _i1.Session session,
    Password row, {
    _i1.ColumnSelections<PasswordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Password>(
      row,
      columns: columns?.call(Password.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Password]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Password>> delete(
    _i1.Session session,
    List<Password> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Password>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Password].
  Future<Password> deleteRow(
    _i1.Session session,
    Password row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Password>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Password>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PasswordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Password>(
      where: where(Password.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PasswordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Password>(
      where: where?.call(Password.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
