class PurchaseItem {
  final String name;
  final double price;

  PurchaseItem({required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price};
  }

  factory PurchaseItem.fromMap(Map<String, dynamic> map) {
    return PurchaseItem(
      name: map['name'],
      price: map['price'],
    );
  }
}

class PurchaseRecord {
  final int? id;
  final String date;
  final double total;
  final List<PurchaseItem> items;

  PurchaseRecord({
    this.id,
    required this.date,
    required this.total,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'total': total,
    };
  }

  factory PurchaseRecord.fromMap(Map<String, dynamic> map, List<PurchaseItem> items) {
    return PurchaseRecord(
      id: map['id'],
      date: map['date'],
      total: map['total'],
      items: items,
    );
  }
}
