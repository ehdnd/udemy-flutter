import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  /// 선택된 tab의 index
  /// body에서 보여지는 화면 변경에 사용
  int _selectedPageIndex = 0;

  /// 선택된 tab의 index를 업데이트
  /// 인덱스를 수정하고 화면 갱신
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 선택된 tab에 따라서 보여지는 화면
    /// 초기 선택된 tab은 카테고리 화면
    Widget activePage = const CategoriesScreen();

    /// 선택된 tab에 따라서 타이틀 변경
    var activePageTitle = 'Categories';

    // 인덱스가 1인 경우 (다르다면) 다른 화면 표시 필요
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        // user의 favorite meal list 전달
        meals: [],
      );
      // app bar 타이틀 변경
      activePageTitle = 'Favorites';
    }

    // `favorite screen` 은 `meals screen` 과 동일한 화면 구조이므로 재사용

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
