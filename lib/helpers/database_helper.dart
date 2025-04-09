import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'receipt_tracker.db');

    return openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE receipts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            total REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE receipt_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            receipt_id INTEGER,
            name TEXT,
            price REAL,
            FOREIGN KEY (receipt_id) REFERENCES receipts(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }
}
