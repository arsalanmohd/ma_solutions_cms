import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ma_solutions_cms/data/models/rentals/rental_model.dart';

class RentalDB {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'rental.db');
    return await openDatabase(
      path,
      version: 2, // Increase version
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
          CREATE TABLE IF NOT EXISTS customers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');
        }
      },
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE products (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
      ''');

        await db.execute('''
        CREATE TABLE customers (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
      ''');

        await db.execute('''
        CREATE TABLE rentals (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          productId INTEGER NOT NULL,
          customerId INTEGER NOT NULL,
          rentalDate TEXT NOT NULL,
          returnDate TEXT,
          quantity INTEGER NOT NULL,
          totalPrice REAL NOT NULL,
          status TEXT NOT NULL,
          FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE,
          FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE CASCADE
        )
      ''');
      },
    );
  }


  static Future<int> updateReturnDate(int rentalId, String returnDate) async {
    final db = await getDatabase();
    var result = await db.rawQuery("PRAGMA foreign_keys;");
    print("Foreign Keys Enabled: ${result.first.values.first}");
    return await db.update(
      'rentals',
      {'returnDate': returnDate},
      where: 'id = ?',
      whereArgs: [rentalId],
    );

  }


  static Future<int?> insertRental(Rental rental) async {

    final db = await getDatabase();
    return await db.insert('rentals', rental.toMap());

    // final db = await RentalDB._database;
    // int? id = await db?.insert('rentals', rental.toMap());
    // print("Inserted rental with ID: $id");
    // return id; // Ensure ID is returned
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await getDatabase();
    return await db.query('products'); // Assuming products table exists
  }

  static Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await getDatabase();
    return await db.query('customers'); // Assuming customers table exists
  }



  static Future<List<Rental>> getALLRentals() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('rentals');
    return List.generate(maps.length, (i) {
      return Rental.fromMap(maps[i]);
    });


  }


}