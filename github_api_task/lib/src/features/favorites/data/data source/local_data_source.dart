import 'package:github_api_task/src/core/errors/exceptions.dart';
import 'package:github_api_task/src/models/github_user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      print('Database::: ${_database!.rawQuery('SELECT * FROM favorites')}');
      return _database!;
    }
    print('db == null');
    _database = await _initDB('favorites.db');

    return _database!;
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading database from version $oldVersion to $newVersion');
    if (oldVersion < newVersion) {
      // Drop the existing table
      await db.execute('DROP TABLE IF EXISTS favorites');

      // Recreate the table with the correct structure
      await _createDB(db, newVersion);
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 6, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY ,
        name TEXT,
        is_favorite INTEGER,
        avatar_url TEXT,
        html_url TEXT,
        bio TEXT,
        public_repos INTEGER,
        public_gists INTEGER,
        followers INTEGER,
        following INTEGER
      )
    ''');
    print("Database created successfully");
  }

  Future<int> addFavorite(GithubUser user) async {
    try {
      
    
    final db = await database;
    return await db.insert('favorites', user.toMap(isFav: true),
        conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
      throw AddLocalDataException();
    }
  }

  Future<List<GithubUser>> getFavorites() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('favorites');
      return List.generate(maps.length, (i) {
        return GithubUser.fromJson(maps[i]);
      });
    } catch (e) {
      throw GetLocalDataException();
    }
  }

  Future<int> deleteFavorite(int id) async {
    try {
      final db = await database;
      return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw DeleteLocalDataException();
    }
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
