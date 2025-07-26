import 'package:flutter/material.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

/// 카테고리 목록을 그리드 형태로 표시하는 화면
///
/// 주요 기능:
/// - availableCategories를 2x4 그리드로 표시
/// - 카테고리 선택 시 해당 meal들을 필터링하여 MealsScreen으로 이동
/// - 즐겨찾기 콜백을 하위 화면으로 전달 (Pass-through 역할)
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });

  /// 즐겨찾기 토글 콜백 함수 (TabsScreen에서 전달받음)
  ///
  /// 역할: 이 화면에서는 단순히 하위 화면으로 전달만 함 (Pass-through)
  /// 실제 사용: MealsScreen → MealDetailsScreen에서 호출됨
  ///
  /// 콜백 체인: TabsScreen → CategoriesScreen → MealsScreen → MealDetailsScreen
  final Function(Meal) onToggleFavorite;

  final List<Meal> availableMeals;

  /// 카테고리 선택 시 해당 카테고리의 meal들을 필터링하여 MealsScreen으로 이동
  ///
  /// @param context 네비게이션에 필요한 BuildContext
  /// @param category 선택된 카테고리 객체
  void _selectCategory(BuildContext context, Category category) {
    // dummyMeals에서 선택된 카테고리에 속하는 meal들만 필터링
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // MealsScreen으로 네비게이션 (필터링된 meal 목록과 콜백 함수 전달)
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          // 중요: 콜백 함수를 계속 전달하여 하위에서 즐겨찾기 기능 사용 가능
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2열 그리드
        childAspectRatio: 3 / 2, // 카드 비율 (3:가로, 2:세로)
        crossAxisSpacing: 20, // 가로 간격
        mainAxisSpacing: 20, // 세로 간격
      ),
      children: [
        // availableCategories에서 각 카테고리를 CategoryGridItem으로 변환
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            // 카테고리 선택 시 _selectCategory 호출
            onSelectCategory: () => _selectCategory(context, category),
          ),
      ],
    );
  }
}
