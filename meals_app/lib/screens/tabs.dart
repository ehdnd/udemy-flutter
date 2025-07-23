import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
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

  /// 즐겨찾기 상태를 토글하는 핵심 비즈니스 로직
  ///
  /// @param meal 즐겨찾기 상태를 변경할 meal 객체
  ///
  /// 동작:
  /// - 이미 즐겨찾기라면 → 제거
  /// - 즐겨찾기가 아니라면 → 추가
  /// - setState() 호출로 UI 자동 업데이트
  void _toggleMealFavoriteStatus(Meal meal) {
    // 현재 즐겨찾기 목록에 해당 meal이 있는지 확인
    final isExistingFavorite = _favoriteMeals.contains(meal);

    setState(() {
      if (isExistingFavorite) {
        _favoriteMeals.remove(meal);
      } else {
        _favoriteMeals.add(meal);
      }
    });
  }

  /// 선택된 tab의 index를 업데이트
  /// 인덱스를 수정하고 화면 갱신
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 현재 선택된 탭에 따라 표시할 화면
    /// 기본값: Categories 화면
    Widget activePage = CategoriesScreen(
      // 콜백 함수를 전달하여 하위 위젯에서 상태 변경 가능하게 함
      onToggleFavorite: _toggleMealFavoriteStatus,
    );

    /// AppBar에 표시될 제목 (탭에 따라 동적 변경)
    var activePageTitle = 'Categories';

    // Favorites 탭 선택시
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        // 즐겨찾기 목록을 전달
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
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
