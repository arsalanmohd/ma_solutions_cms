import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ma_solutions_cms/data/models/payment/payment_model.dart';

class PaymentDB {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'payment.db');
    return await openDatabase(
        path,
      version: 1,
      onConfigure: (db) async {
        // Enabling foreign key
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE payments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rentalId INTEGER,
        FOREIGN KEY (rentalId) REFERENCES rentals(id),
        amountPaid REAL,
        paymentDate DATE,
        paymentMode TEXT
        )
        ''');
      },
    );
  }

  static Future<int> insertPayment(Payment payment) async {
    final db = await getDatabase();
    return await db.insert('payments', payment.toMap());
  }

  static Future<List<Map<String, dynamic>>> getRentals() async {
    final db = await getDatabase();
    return await db.query('rentals'); // Assuming products table exists
  }

  static Future<List<Payment>> getAllPayments() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('payment');
    return List.generate(maps.length, (i) {
      return Payment.fromMap(maps[i]);
    });
  }
}