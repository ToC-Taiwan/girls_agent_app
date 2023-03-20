// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TimeLineDao? _timeLineDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `time_line` (`year` TEXT NOT NULL, `month` TEXT NOT NULL, `day` TEXT NOT NULL, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `create_time` INTEGER NOT NULL, `update_time` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TimeLineDao get timeLineDao {
    return _timeLineDaoInstance ??= _$TimeLineDao(database, changeListener);
  }
}

class _$TimeLineDao extends TimeLineDao {
  _$TimeLineDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _timeLineInsertionAdapter = InsertionAdapter(
            database,
            'time_line',
            (TimeLine item) => <String, Object?>{
                  'year': item.year,
                  'month': item.month,
                  'day': item.day,
                  'id': item.id,
                  'create_time': item.createTime,
                  'update_time': item.updateTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TimeLine> _timeLineInsertionAdapter;

  @override
  Future<List<TimeLine>> getAllTimeLine() async {
    return _queryAdapter.queryList('SELECT * FROM time_line',
        mapper: (Map<String, Object?> row) => TimeLine(
            row['year'] as String, row['month'] as String, row['day'] as String,
            id: row['id'] as int?,
            createTime: row['create_time'] as int?,
            updateTime: row['update_time'] as int?));
  }

  @override
  Stream<TimeLine?> getTimeLineByID(int id) {
    return _queryAdapter.queryStream('SELECT * FROM time_line WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TimeLine(
            row['year'] as String, row['month'] as String, row['day'] as String,
            id: row['id'] as int?,
            createTime: row['create_time'] as int?,
            updateTime: row['update_time'] as int?),
        arguments: [id],
        queryableName: 'time_line',
        isView: false);
  }

  @override
  Future<TimeLine?> getLastTimeLine() async {
    return _queryAdapter.query(
        'SELECT * FROM time_line WHERE id !=0 ORDER BY id desc LIMIT 1',
        mapper: (Map<String, Object?> row) => TimeLine(
            row['year'] as String, row['month'] as String, row['day'] as String,
            id: row['id'] as int?,
            createTime: row['create_time'] as int?,
            updateTime: row['update_time'] as int?));
  }

  @override
  Future<void> insertTimeLine(TimeLine t) async {
    await _timeLineInsertionAdapter.insert(t, OnConflictStrategy.abort);
  }
}
