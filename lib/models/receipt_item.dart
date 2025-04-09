class ReceiptItem {
  int? id;
  int? receiptId; // Ubah: dari required menjadi nullable
  String name;
  double price;

  ReceiptItem({
    this.id,
    this.receiptId,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'receiptId': receiptId,
      'name': name,
      'price': price,
    };
  }

  factory ReceiptItem.fromMap(Map<String, dynamic> map) {
    return ReceiptItem(
      id: map['id'],
      receiptId: map['receiptId'],
      name: map['name'],
      price: map['price'],
    );
  }
}
