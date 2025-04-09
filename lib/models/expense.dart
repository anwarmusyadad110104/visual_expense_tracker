class Expense {
  final int? id;
  final String store;
  final double total;
  final DateTime date;
  final String location;
  final List<String> items;

  Expense({
    this.id,
    required this.store,
    required this.total,
    required this.date,
    required this.location,
    required this.items,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'store': store,
        'total': total,
        'date': date.toIso8601String(),
        'location': location,
        'items': items.join(','),
      };

  factory Expense.fromMap(Map<String, dynamic> map) => Expense(
        id: map['id'],
        store: map['store'],
        total: map['total'],
        date: DateTime.parse(map['date']),
        location: map['location'],
        items: (map['items'] as String).split(','),
      );
}
