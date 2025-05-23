import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/database_service.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  Future<void> loadExpenses() async {
    _expenses = await DatabaseService.getAllExpenses();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await DatabaseService.insertExpense(expense);
    _expenses.add(expense);
    notifyListeners();
  }
}
