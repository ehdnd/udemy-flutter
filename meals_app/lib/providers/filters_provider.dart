import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  gluten,
  lactose,
  vegan,
  vegetarian,
}

/// filter의 Map을 관리한다
class FlilterProvider extends StateNotifier<Map<Filter, bool>> {
  /// 초기값 설정
  FlilterProvider()
    : super({
        Filter.gluten: false,
        Filter.lactose: false,
        Filter.vegan: false,
        Filter.vegetarian: false,
      });

  void setFilter(Filter filter, bool isActive) {
    /// immutable 하게 변경해야한다
    state = {
      // 기존의 Map을 복사하고
      ...state,
      // 특정 filter의 값을 변경할 수 있다
      // 키-값 쌍을 덮어쓰게 된다
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> activeFilters) {
    state = activeFilters;
  }
}

final filterProvider =
    StateNotifierProvider<FlilterProvider, Map<Filter, bool>>(
      (ref) => FlilterProvider(),
    );

/// 필터링된 meals 목록을 반환하자
/// 앞서 tabs.dart의 build 메서드에서 수행하던 로직을 이곳에서 수행하자
/// `filterProvider`와 `mealsProvider` 두 개의 provider를 사용
final filteredMealsProvider = Provider<List<Meal>>((ref) {
  /// 값이 바뀌면 함수가 다시 실행된다
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.gluten]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactose]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
