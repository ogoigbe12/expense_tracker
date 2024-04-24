import 'package:expense_tracker/models/expenses.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expenses> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => ExpensesItem(expenses[index]));
  }
}
