import 'package:expense_tracker/widget/expenses_list/list_expenses.dart';
import 'package:expense_tracker/models/expenses.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<Expenses> _registeredExpenses = [
    Expenses(
      amount: 5000000,
      category: Category.food,
      date: DateTime.now(),
      title: 'rice',
    ),
    Expenses(
      amount: 10000,
      category: Category.leisure,
      date: DateTime.now(),
      title: 'pool bath',
    )
  ];

  void _addExpense(Expenses expenses) {
    setState(() {
      _registeredExpenses.add(expenses);
    });
  }

  void _removeExpense(Expenses expenses) {
    setState(() {
      _registeredExpenses.remove(expenses);
    });
  }

  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Chart'),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
              onRemovedExpenses: _removeExpense,
            ),
          ),
        ],
      ),
    );
  }
}
