import 'package:sqflite/sqflite.dart';
import 'package:submission_1/data/model/local/favorite_restaurants.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  static late Database _database;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurants.db'),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
             id TEXT PRIMARY KEY,
             name TEXT,
             pictureId TEXT,
             city TEXT,
             rating TEXT
           )     
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(FavoriteRestaurants restaurant) async {
    final db = await database;
    await db.insert(_tblFavorite, restaurant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FavoriteRestaurants>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblFavorite);

    return results.map((res) => FavoriteRestaurants.fromMap(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
