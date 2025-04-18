import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ma_solutions_cms/data/models/user/user_model.dart';

class UserDB {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'user.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userName TEXT UNIQUE,
        password TEXT HASHED,
        role TEXT
        )
        ''');
      },
    );
  }

  // Insert Data
  static Future<int> insertUser(User user) async{
    final db = await getDatabase();
    return await db.insert('users', user.toMap());
  }

  // Fetch All Data
  static Future<List<User>> getAllUsers() async{
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]); // Ensure fromMap is available
    });
  }
}