import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

/// meal 목록을 표시하는 재사용 가능한 화면
///
/// 사용 예:
/// 1. Categories에서 카테고리 선택 시 - 해당 카테고리의 meal 목록 표시
/// 2. Favorites 탭 - 즐겨찾기된 meal 목록 표시
///
/// 주요 기능:
/// - meal 목록을 ListView로 표시
/// - meal 선택 시 MealDetailsScreen으로 네비게이션
/// - 즐겨찿기 콜백을 MealDetailsScreen으로 전달
class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    // required this.onToggleFavorite,
  });

  /// 화면 제목 (선택적)
  /// - Categories에서 온 경우: 카테고리 이름 (예: "Italian")
  /// - Favorites 탭인 경우: null (TabsScreen에서 AppBar 제목 처리)
  final String? title;

  /// 표시할 meal 목록
  /// - Categories에서 온 경우: 해당 카테고리로 필터링된 meal들
  /// - Favorites 탭인 경우: 즐겨찾기된 meal들
  final List<Meal> meals;

  /// 즐겨찾기 토글 콜백 함수 (최종적으로 MealDetailsScreen에 전달됨)
  ///
  /// 이 화면의 역할: 콜백 함수를 MealDetailsScreen으로 전달 (Pass-through)
  /// 실제 호출: MealDetailsScreen의 AppBar 즐겨찾기 버튼에서 발생
  // final Function(Meal) onToggleFavorite;

  /// meal 선택 시 상세 화면으로 이동하는 내비게이션 로직
  ///
  /// @param context 네비게이션에 필요한 BuildContext
  /// @param meal 선택된 meal 객체
  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          // 핵심: 즐겨찾기 콜백을 최종 목적지에 전달
          // onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 기본 UI: 해당하는 meal이 없을 때 표시되는 안내 메시지
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No meals found.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );

    // meal 목록이 있는 경우 ListView로 표시
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          // MealItem의 onSelectMeal 콜백에 _selectMeal 함수 연결
          onSelectMeal: (meal) => _selectMeal(context, meal),
        ),
      );
    }

    // title이 null인 경우 (Favorites 탭) Scaffold 없이 content만 반환
    if (title == null) {
      return content;
    }

    // title이 있는 경우 (Categories에서 온 경우) 완전한 Scaffold 반환
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
