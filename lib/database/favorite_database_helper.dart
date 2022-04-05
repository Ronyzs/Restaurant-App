import 'package:restaurant_app/database/model/restoran_detail.dart';
import 'package:restaurant_app/database/model/restoran_favorit.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _favMark = 'favorit';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      "$path/restoranapp.db",
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_favMark (
             id TEXT PRIMARY KEY,
             namaTempat TEXT,
             city TEXT,
             picId TEXT,
             rating TEXT
           )     
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertFav(Restaurant_Detail resto) async {
    final db = await database;
    var value = {
      'id': resto.id,
      'namaTempat': resto.namaTempat,
      'city': resto.city,
      'picId': resto.picId,
      'rating': resto.rating.toString(),
    };
    await db!.insert(_favMark, value);
  }

  Future<List<RestoranFavorit>> getFav() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favMark);

    return results.map((e) => RestoranFavorit.fromDb(e)).toList();
  }

  Future<Map> getFavById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _favMark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFav(String id) async {
    final db = await database;

    await db!.delete(
      _favMark,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
