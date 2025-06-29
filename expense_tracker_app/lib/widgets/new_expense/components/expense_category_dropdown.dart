import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class ExpenseCategoryDropdown extends StatelessWidget {
  const ExpenseCategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final Category selectedCategory;
  final void Function(Category) onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        onCategoryChanged(value);
      },
    );
  }
}
