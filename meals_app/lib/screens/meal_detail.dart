import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Column(
        children: [
          ...meal.ingredients.map(
            (ingredient) => Text(ingredient),
          ),
          ...meal.steps.map(
            (step) => Text(step),
          ),
          Text('isGlutenFree: ${meal.isGlutenFree}'),
          Text('isVegan: ${meal.isVegan}'),
          Text('isVegetarian: ${meal.isVegetarian}'),
          Text('isLactoseFree: ${meal.isLactoseFree}'),
        ],
      ),
    );
  }
}
