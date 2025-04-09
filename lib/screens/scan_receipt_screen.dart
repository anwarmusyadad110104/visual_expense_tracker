// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../models/receipt.dart';
import '../models/receipt_item.dart';
import '../services/receipt_parser.dart';
import '../services/receipt_service.dart';

class ScanReceiptScreen extends StatefulWidget {
  const ScanReceiptScreen({super.key});

  @override
  State<ScanReceiptScreen> createState() => _ScanReceiptScreenState();
}

class _ScanReceiptScreenState extends State<ScanReceiptScreen> {
  String scannedText = '';
  final ImagePicker _picker = ImagePicker();
  final ReceiptService _receiptService = ReceiptService();

  void _scanReceipt() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    final inputImage = InputImage.fromFile(File(pickedFile.path));
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    final text = recognizedText.text;
    setState(() {
      scannedText = text;
    });

    final parser = ReceiptParser();
    final items = parser.parse(text);
    final total = parser.extractTotal(text);

    final receipt = Receipt(date: DateTime.now(), total: total);
    await _receiptService.insertReceipt(receipt, items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Struk')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: scannedText.isEmpty
            ? const Center(child: Text('Scan struk menggunakan kamera.'))
            : SingleChildScrollView(child: Text(scannedText)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanReceipt,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
