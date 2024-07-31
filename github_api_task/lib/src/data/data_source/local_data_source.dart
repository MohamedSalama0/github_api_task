import 'package:github_api_task/src/models/github_user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        githubId INTEGER,
        name TEXT,
        avatarUrl TEXT,
        htmlUrl TEXT,
        bio TEXT,
        publicRepos INTEGER,
        publicGists INTEGER,
        followers INTEGER,
        following INTEGER
      )
    ''');
  }

  Future<int> addFavorite(GithubUser user) async {
    final db = await database;
    return await db.insert('favorites', user.toMap());
  }

  Future<List<GithubUser>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return GithubUser.fromJson(maps[i]);
    });
  }

  Future<int> deleteFavorite(int id) async {
    final db = await database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'githubId = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
