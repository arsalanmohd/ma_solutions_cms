import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ma_solutions_cms/data/models/products/product_model.dart';

class ProductDB {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'product.db');
    return await openDatabase(
        path,
      version: 1,
      onCreate: (db, version) {
          return db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            photoPath TEXT,
            name TEXT,
            rentalPricePerDay REAL,
            availableQuantity INTEGER,
            status TEXT
            )
          ''');
      },
    );
  }


  // Insert Data
  static Future<int> insertProduct(Product product) async {
    final db = await getDatabase();
    return await db.insert('products', product.toMap());
  }

  static Future<Product?> getProductById(int id) async {
    final db = await getDatabase();
    final maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    }
    return null;
  }

  static Future<void> updateProduct(Product product) async {
    final db = await getDatabase();
    await db.update('products', product.toMap(), where: 'id = ?', whereArgs: [product.id]);
  }

  // Fetch Data
  static Future<List<Product>> getAllProducts() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    }
    );
  }
}