import 'package:flutter/material.dart';

class ExpenseAmountField extends StatelessWidget {
  const ExpenseAmountField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$',
        label: Text('Amount'),
      ),
    );
  }
}
