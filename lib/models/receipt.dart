class Receipt {
  int? id;
  DateTime date;
  double total;

  Receipt({this.id, required this.date, required this.total});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'total': total,
    };
  }

  factory Receipt.fromMap(Map<String, dynamic> map) {
    return Receipt(
      id: map['id'],
      date: DateTime.parse(map['date']),
      total: map['total'] is int ? (map['total'] as int).toDouble() : map['total'],
    );
  }
}
