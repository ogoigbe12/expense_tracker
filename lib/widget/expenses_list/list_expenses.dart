import 'package:expense_tracker/models/expenses.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemovedExpenses});

  final List<Expenses> expenses;

  final void Function(Expenses expenses) onRemovedExpenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          onRemovedExpenses(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
