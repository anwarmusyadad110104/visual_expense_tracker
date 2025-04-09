import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text('${expense.store} - \$${expense.total.toStringAsFixed(2)}'),
        subtitle: Text('${expense.date.toLocal()} \n@ ${expense.location}'),
      ),
    );
  }
}
