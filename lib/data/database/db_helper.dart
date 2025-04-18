import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/dashboard_model.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'dashboard.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE dashboards(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            dCustomerName TEXT,
            dProductName TEXT,
            dCustomerNumber TEXT,
            dOccupation TEXT,
            date TEXT,
            dPrice INTEGER,
            pStatus INTEGER,
            rStatus INTEGER
          )
        ''');
      },
    );
  }

  // Insert data
  static Future<int> insertDashboard(Dashboard dashboard) async {
    final db = await getDatabase();
    return await db.insert('dashboards', dashboard.toMap());
  }

  // Fetch all data
  static Future<List<Dashboard>> getAllDashboards() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('dashboards');

    return List.generate(maps.length, (i) {
      return Dashboard.fromMap(maps[i]); // Ensure fromMap is available
    });
  }
}
