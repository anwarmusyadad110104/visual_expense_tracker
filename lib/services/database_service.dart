import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';

class DatabaseService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'expense.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE expenses (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          store TEXT,
          total REAL,
          date TEXT,
          location TEXT,
          items TEXT
        )
        ''');
      },
    );
  }

  static Future<void> insertExpense(Expense expense) async {
    final db = await database;
    await db.insert('expenses', expense.toMap());
  }

  static Future<List<Expense>> getAllExpenses() async {
    final db = await database;
    final maps = await db.query('expenses');
    return maps.map((e) => Expense.fromMap(e)).toList();
  }
}
