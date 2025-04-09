import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/receipt.dart';
import '../services/receipt_service.dart';

class ReceiptHistoryScreen extends StatelessWidget {
  const ReceiptHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Belanja')),
      body: FutureBuilder<List<Receipt>>(
        future: ReceiptService().getAllReceipts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data struk.'));
          }

          final receipts = snapshot.data!;
          return ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final receipt = receipts[index];
              return ListTile(
                title: Text('Total: Rp ${receipt.total.toStringAsFixed(2)}'),
                subtitle: Text(DateFormat('dd-MM-yyyy HH:mm').format(receipt.date)),
              );
            },
          );
        },
      ),
    );
  }
}
