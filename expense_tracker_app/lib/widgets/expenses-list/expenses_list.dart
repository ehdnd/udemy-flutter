import 'package:flutter/material.dart';

import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses-list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
