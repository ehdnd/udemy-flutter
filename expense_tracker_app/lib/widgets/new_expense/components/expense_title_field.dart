import 'package:flutter/material.dart';

class ExpenseTitleField extends StatelessWidget {
  const ExpenseTitleField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
  }
}
