import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class ExpenseDatePicker extends StatelessWidget {
  const ExpenseDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  final DateTime? selectedDate;
  final void Function(DateTime?) onDateChanged;

  void _presentDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    onDateChanged(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          selectedDate == null
              ? 'No date selected'
              : formatter.format(selectedDate!),
        ),
        IconButton(
          onPressed: () => _presentDatePicker(context),
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
