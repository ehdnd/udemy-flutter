import 'package:flutter_riverpod/flutter_riverpod.dart';

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
