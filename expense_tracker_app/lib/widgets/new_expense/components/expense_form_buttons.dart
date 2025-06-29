import 'package:flutter/material.dart';

class ExpenseFormButtons extends StatelessWidget {
  const ExpenseFormButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSave,
          child: const Text('Save Expense'),
        ),
      ],
    );
  }
}
