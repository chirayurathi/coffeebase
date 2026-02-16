import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('coffee.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes(
        id INTEGER PRIMARY KEY,
        bean TEXT,
        method TEXT,
        grind_size TEXT,
        water_temp REAL,
        coffee_weight REAL,
        water_weight REAL,
        description TEXT
      )
    ''');
  }

  Future<void> insertRecipe(Map<String, dynamic> recipe) async {
    final db = await instance.database;
    await db.insert('recipes', recipe);
  }

  Future<List<Map<String, dynamic>>> getRecipes() async {
    final db = await instance.database;
    return await db.query('recipes');
  }
}
