import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';

/// 개별 meal의 상세 정보를 표시하는 화면
/// 
/// 주요 기능:
/// - meal 이미지, 재료, 조리 방법 표시
/// - AppBar에 즐겨찾기 토글 버튼 제공
/// - 즐겨찾기 상태 변경 시 TabsScreen의 상태 업데이트
class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
  });

  /// 상세 정보를 표시할 meal 객체
  final Meal meal;

  /// 즐겨찾기 토글 함수 (TabsScreen에서 시작된 콜백 체인의 최종 목적지)
  /// 
  /// 호출 시점: 사용자가 AppBar의 즐겨찾기 버튼(⭐)을 탭할 때
  /// 결과: TabsScreen의 _favoriteMeals 목록이 업데이트되고 UI가 리빌드됨
  final Function(Meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            /// 즐겨찾기 토글 버튼
            /// 
            /// 동작: 현재 meal을 인자로 onToggleFavorite 콜백 호출
            /// 결과: TabsScreen의 상태가 변경되어 Favorites 탭에 즉시 반영
            onPressed: () => onToggleFavorite(meal),
            
            // TODO: 즐겨찾기 상태에 따라 아이콘 변경 필요
            // 현재: 항상 동일한 아이콘
            // 개선: 즐겨찾기 상태를 받아서 filled/outlined 구분
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // meal 이미지 표시 영역
            Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
              // TODO: 로딩 상태와 에러 상태 처리 추가
            ),
            const SizedBox(height: 14),
            
            // 재료 섹션
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            // 각 재료를 개별 Text 위젯으로 표시
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            const SizedBox(height: 24),
            
            // 조리 방법 섹션
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            // 각 단계를 번호와 함께 표시 (개선 가능)
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
