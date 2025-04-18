import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ma_solutions_cms/data/models/customers/customer_model.dart';

class CustomerDB {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'customer.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE customers(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          contact TEXT,
          address TEXT,
          occupation TEXT,
          statusPaid TEXT,
          statusReturned TEXT
          )
          ''');
      },
    );



  }


  // Insert Data
  static Future<int> insertCustomer(Customer customer) async {
    final db = await getDatabase();
    return await db.insert('customers', customer.toMap());
  }

  static Future<Customer?> getCustomerById(int id) async {
    final db = await getDatabase();
    final maps = await db.query(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer.fromMap(maps.first);
    }
    return null;
  }


  // Fetch Data
  static Future<List<Customer>> getAllCustomers() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('customers');
    return List.generate(maps.length, (i) {
      return Customer.fromMap(maps[i]);
    });
  }
}