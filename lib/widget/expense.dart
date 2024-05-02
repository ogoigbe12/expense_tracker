import 'package:expense_tracker/widget/chart/chart.dart';
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
      amount: 36000,
      category: Category.work,
      date: DateTime.now(),
      title: 'flutter&dart complete guide',
    ),
    Expenses(
      amount: 10300,
      category: Category.leisure,
      date: DateTime.now(),
      title: 'cinema',
    )
  ];

  void _addExpense(Expenses expenses) {
    setState(() {
      _registeredExpenses.add(expenses);
    });
  }

  void _removeExpense(Expenses expenses) {
    final expenseIndex = _registeredExpenses.indexOf(expenses);
    setState(() {
      _registeredExpenses.remove(expenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expenses Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expenses);
            });
          },
        ),
      ),
    );
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
    Widget mainConnect = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainConnect = ExpensesList(
        expenses: _registeredExpenses,
        onRemovedExpenses: _removeExpense,
      );
    }

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
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainConnect),
        ],
      ),
    );
  }
}
