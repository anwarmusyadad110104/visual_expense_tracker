import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:visual_expense_tracker/main.dart';

void main() {
  testWidgets('App renders HomeScreen with title', (WidgetTester tester) async {
    // Jalankan aplikasi
    await tester.pumpWidget(const MyApp());

    // Verifikasi ada judul atau elemen utama HomeScreen
    expect(find.text('Visual Expense Tracker'), findsOneWidget);

    // Verifikasi tombol kamera tersedia
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
  });

  testWidgets('Navigates to ScanReceiptScreen when camera button tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap tombol kamera
    await tester.tap(find.byIcon(Icons.camera_alt));
    await tester.pumpAndSettle();

    // Verifikasi berpindah ke halaman scan
    expect(find.textContaining('Scan'),
        findsOneWidget); // Pastikan ada teks "Scan"
  });
}
