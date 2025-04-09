import '../helpers/database_helper.dart';
import '../models/receipt.dart';
import '../models/receipt_item.dart';

class ReceiptService {
  final dbHelper = DatabaseHelper();

  Future<void> insertReceipt(Receipt receipt, List<ReceiptItem> items) async {
    final db = await dbHelper.database;
    final receiptId = await db.insert('receipts', receipt.toMap());

    for (var item in items) {
      item.receiptId = receiptId;
      await db.insert('receipt_items', item.toMap());
    }
  }

  Future<List<Receipt>> getAllReceipts() async {
    final db = await dbHelper.database;
    final maps = await db.query('receipts', orderBy: 'date DESC');
    return maps.map((e) => Receipt.fromMap(e)).toList();
  }

  Future<List<ReceiptItem>> getItemsByReceiptId(int receiptId) async {
    final db = await dbHelper.database;
    final maps = await db.query('receipt_items',
        where: 'receipt_id = ?', whereArgs: [receiptId]);
    return maps.map((e) => ReceiptItem.fromMap(e)).toList();
  }

  Future<void> deleteReceipt(int id) async {
    final db = await dbHelper.database;
    await db.delete('receipts', where: 'id = ?', whereArgs: [id]);
  }
}
