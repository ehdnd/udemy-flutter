import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  /// 현재 선택된 탭의 인덱스 (0: Categories, 1: Favorites)
  /// BottomNavigationBar와 연동되어 화면 전환에 사용
  int _selectedPageIndex = 0;

  /// 전체 앱의 즐겨찾기 meal 목록 (Single Source of Truth)
  ///
  /// Lifting State Up 패턴으로 관리:
  /// - Categories 탭: MealDetailsScreen에서 즐겨찾기 추가/제거
  /// - Favorites 탭: 즐겨찾기된 meal들을 표시
  ///
  /// 두 탭이 동일한 데이터를 공유하므로 가장 가까운 공통 조상에서 관리
  final List<Meal> _favoriteMeals = [];

  /// filters.dart 에서 선택한 필터 상태 저장
  /// 이제는 Provider가 관리하므로 삭제
  // Map<Filter, bool> _selectedFilters = {};

  /// 메시지를 표시하는 함수
  /// 별표 표시 / 제거 대신 메시지를 표시
  void _showInfoMessage(String message) {
    // 먼저 기존 메시지 제거
    ScaffoldMessenger.of(context).clearSnackBars();

    // 새로운 메시지 추가
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// 즐겨찾기 상태를 토글하는 핵심 비즈니스 로직
  ///
  /// @param meal 즐겨찾기 상태를 변경할 meal 객체
  ///
  /// 동작:
  /// - 이미 즐겨찾기라면 → 제거
  /// - 즐겨찾기가 아니라면 → 추가
  /// - setState() 호출로 UI 자동 업데이트
  ///
  /// -> 이제 이 로직은 Provider가 수행하므로 삭제
  /// StateNotifier의 메서드를 호출하면 자동으로 UI 업데이트 된다.

  /// 선택된 tab의 index를 업데이트
  /// 인덱스를 수정하고 화면 갱신
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    // 메뉴 닫기 (모달 또는 dialog 창 닫기)
    // state class 라 가능
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
      // Map<Filter, bool> 이 리턴될 것을 개발자는 알고 있지
      // 빌드 메서드가 실제로 수행되어야 하므로 setState 사용
      // -> 이제는 필터 상태를 Provider가 관리하므로 삭제
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    // final activeFilters = ref.watch(filterProvider);

    // `CategoriesScreen` 에는 미리 필터링한 meals 데이터 제공
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.gluten]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactose]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    /// 현재 선택된 탭에 따라 표시할 화면
    /// 기본값: Categories 화면
    Widget activePage = CategoriesScreen(
      // 콜백 함수를 전달하여 하위 위젯에서 상태 변경 가능하게 함
      // -> 모든 위젯 레이어를 통과했는데 provider 도입으로 필요없다
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );

    /// AppBar에 표시될 제목 (탭에 따라 동적 변경)
    var activePageTitle = 'Categories';

    // Favorites 탭 선택시
    if (_selectedPageIndex == 1) {
      /// provider 에서 즐겨찾기 목록을 가져온다
      /// state를 자동으로 넘겨주니 List<Meal> 타입
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        // 즐겨찾기 목록을 전달
        meals: favoriteMeals,
        // 모든 위젯 레이어를 통과했는데 provider 도입으로 필요없다
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      // app bar 타이틀 변경
      activePageTitle = 'Favorites';
    }

    // Favorites 화면은 MealsScreen을 재사용하여 구현 (DRY 원칙)

    return Scaffold(
      appBar: AppBar(
        // 선택된 tab에 따라서 타이틀 변경
        title: Text(activePageTitle),
      ),

      /// 메뉴 버튼 클릭시 나오는 메뉴 위젯
      /// 이제 main_drawer 는 tabs 화면과 소통 가능
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),

      // 선택된 tab에 따라서 보여지는 화면 변경
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
