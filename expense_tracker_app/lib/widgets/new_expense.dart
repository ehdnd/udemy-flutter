import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';

import 'package:expense_tracker_app/models/expense.dart';
import 'new_expense/layouts/mobile_expense_layout.dart';
import 'new_expense/layouts/desktop_expense_layout.dart';

final uuid = Uuid();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _onDateChanged(DateTime? date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _onCategoryChanged(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  void _showInvalidInputDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, and date was entered.',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, and date was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _onSave() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (enteredTitle.isEmpty || amountIsInvalid || _selectedDate == null) {
      _showInvalidInputDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
              child: width >= 600
                  ? DesktopExpenseLayout(
                      titleController: _titleController,
                      amountController: _amountController,
                      selectedDate: _selectedDate,
                      selectedCategory: _selectedCategory,
                      onDateChanged: _onDateChanged,
                      onCategoryChanged: _onCategoryChanged,
                      onCancel: _onCancel,
                      onSave: _onSave,
                    )
                  : MobileExpenseLayout(
                      titleController: _titleController,
                      amountController: _amountController,
                      selectedDate: _selectedDate,
                      selectedCategory: _selectedCategory,
                      onDateChanged: _onDateChanged,
                      onCategoryChanged: _onCategoryChanged,
                      onCancel: _onCancel,
                      onSave: _onSave,
                    ),
            ),
          ),
        );
      },
    );
  }
}
