import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/receipt.dart';
import '../services/receipt_service.dart';
import 'scan_receipt_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Receipt> receipts = [];

  @override
  void initState() {
    super.initState();
    _loadReceipts();
  }

  Future<void> _loadReceipts() async {
    receipts = await ReceiptService().getAllReceipts();
    setState(() {});
  }

  void _goToScan() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScanReceiptScreen()),
    );
    _loadReceipts();
  }

  Future<void> _deleteReceipt(int id) async {
    await ReceiptService().deleteReceipt(id);
    _loadReceipts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Struk")),
      body: receipts.isEmpty
          ? const Center(child: Text("Belum ada data struk."))
          : ListView.builder(
              itemCount: receipts.length,
              itemBuilder: (context, index) {
                final r = receipts[index];
                return ListTile(
                  title: Text("Scan: ${DateFormat('dd-MM-yyyy HH:mm').format(r.date)}"),
                  subtitle: Text("Total: Rp ${r.total.toStringAsFixed(2)}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Hapus Struk"),
                          content: const Text("Apakah Anda yakin ingin menghapus struk ini?"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
                            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        _deleteReceipt(r.id!);
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToScan,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
