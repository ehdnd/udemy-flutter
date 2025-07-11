import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

import 'package:meals_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    required this.category,
  });

  final String title;
  final List<Meal> meals;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Placeholder(),
    );
  }
}
