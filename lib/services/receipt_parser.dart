import '../models/receipt_item.dart';

class ReceiptParser {
  List<ReceiptItem> parse(String text) {
    final lines = text.split('\n');
    List<ReceiptItem> items = [];

    final itemRegex = RegExp(r'^(.+?)\s+(\d+)?\s*Rp\.?\s?(\d+[\.,]?\d*)$');
    final excludeKeywords = ['total', 'tunai', 'kembalian', 'bayar'];

    for (var line in lines) {
      line = line.trim().toLowerCase();
      if (excludeKeywords.any((kw) => line.contains(kw))) continue;

      final match = itemRegex.firstMatch(line);
      if (match != null) {
        final name = match.group(1)!.trim();
        final priceString = match.group(3)!.replaceAll('.', '').replaceAll(',', '.');
        final price = double.tryParse(priceString) ?? 0.0;
        if (price > 0 && name.isNotEmpty) {
          items.add(ReceiptItem(name: name, price: price));
        }
      }
    }

    return items;
  }

  double extractTotal(String text) {
    final lines = text.toLowerCase().split('\n');
    final totalRegex = RegExp(r'(total|jumlah)\s*[:\-]?\s*rp?\.?\s?(\d+[\.,]?\d*)');

    for (var line in lines.reversed) {
      final match = totalRegex.firstMatch(line);
      if (match != null) {
        final totalStr = match.group(2)!.replaceAll('.', '').replaceAll(',', '.');
        final total = double.tryParse(totalStr);
        if (total != null) return total;
      }
    }

    return 0.0;
  }
}
