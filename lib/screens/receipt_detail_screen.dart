import 'package:flutter/material.dart';
import '../models/receipt.dart';
import '../models/receipt_item.dart';
import '../services/receipt_service.dart';

class ReceiptDetailScreen extends StatefulWidget {
  final Receipt receipt;

  const ReceiptDetailScreen({super.key, required this.receipt});

  @override
  State<ReceiptDetailScreen> createState() => _ReceiptDetailScreenState();
}

class _ReceiptDetailScreenState extends State<ReceiptDetailScreen> {
  final ReceiptService _receiptService = ReceiptService();
  List<ReceiptItem> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await _receiptService.getItemsByReceiptId(widget.receipt.id!);
    setState(() => _items = items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Struk")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tanggal: ${widget.receipt.date}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Total: Rp ${widget.receipt.total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16)),
            const Divider(height: 32),
            const Text("Item Belanja:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: _items.isEmpty
                  ? const Text("Tidak ada item.")
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ListTile(
                          title: Text(item.name),
                          trailing: Text("Rp ${item.price.toStringAsFixed(2)}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
