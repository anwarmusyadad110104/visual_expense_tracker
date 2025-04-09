import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/expense.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analysis')),
      body: FutureBuilder<List<Expense>>(
        future: DatabaseService.getAllExpenses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final expenses = snapshot.data!;
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (_, i) {
              final e = expenses[i];
              return ListTile(
                title: Text('${e.store} - \$${e.total.toStringAsFixed(2)}'),
                subtitle: Text('${e.date} @ ${e.location}'),
              );
            },
          );
        },
      ),
    );
  }
}
