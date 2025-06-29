import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import '../components/expense_title_field.dart';
import '../components/expense_amount_field.dart';
import '../components/expense_date_picker.dart';
import '../components/expense_category_dropdown.dart';
import '../components/expense_form_buttons.dart';

class DesktopExpenseLayout extends StatelessWidget {
  const DesktopExpenseLayout({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.selectedDate,
    required this.selectedCategory,
    required this.onDateChanged,
    required this.onCategoryChanged,
    required this.onCancel,
    required this.onSave,
  });

  final TextEditingController titleController;
  final TextEditingController amountController;
  final DateTime? selectedDate;
  final Category selectedCategory;
  final void Function(DateTime?) onDateChanged;
  final void Function(Category) onCategoryChanged;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ExpenseTitleField(controller: titleController),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ExpenseAmountField(controller: amountController),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            ExpenseCategoryDropdown(
              selectedCategory: selectedCategory,
              onCategoryChanged: onCategoryChanged,
            ),
            Expanded(
              child: ExpenseDatePicker(
                selectedDate: selectedDate,
                onDateChanged: onDateChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ExpenseFormButtons(
          onCancel: onCancel,
          onSave: onSave,
        ),
      ],
    );
  }
}
