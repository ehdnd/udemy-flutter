import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  /// 초기값은 빈 리스트로 설정
  /// 데이터는 아무거나 가능하나 여기서는 list<Meal>로 사용
  FavoriteMealsNotifier() : super([]);

  /// 데이터 편집 메서드를 제공하자
  bool toggleMealFavoriteStatus(Meal meal) {
    /// 현재 즐겨찾기 목록에 해당 meal이 있는지 확인
    final mealIsFavorite = state.contains(meal);

    /// StateNotifier의 state는 불변성을 유지하기 위해 새로운 리스트를 생성
    /// state는 StateNotifier에서 온다
    if (mealIsFavorite) {
      /// 토글하는 meal이 없는 새로운 목록을 가져야해.
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      /// 토글하는 meal이 있는 새로운 목록을 가져야해.
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      (ref) => FavoriteMealsNotifier(),
    );
