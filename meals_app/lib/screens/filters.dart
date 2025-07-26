import 'package:flutter/material.dart';
import 'package:meals_app/widgets/filter_switch_list_tile.dart';

enum Filter {
  gluten,
  lactose,
  vegan,
  vegetarian,
}

/// 유저 인풋 State를 다뤄야하므로 StatefulWidget 사용
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _veganFilterSet = false;
  var _vegetarianFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.gluten]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactose]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    // 새로운 화면이므로 `Scaffold` 사용
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),

      /// PopScope: 사용자의 뒤로가기 동작을 감지하고 커스텀 동작 실행
      ///
      /// canPop: false - 자동 pop을 차단하고 우리가 수동으로 제어
      /// onPopInvokedWithResult - 뒤로가기 시도시 실행되는 콜백
      body: PopScope(
        canPop: false,

        /// 사용자가 뒤로가기를 시도할 때마다 실행되는 콜백
        ///
        /// canPop: false이므로 didPop은 항상 false
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          // canPop: false이므로 didPop은 항상 false
          // 뒤로가기 시도를 감지했으므로 필터 데이터와 함께 pop 실행
          Navigator.of(context).pop(
            /// 현재 설정된 필터 상태를 Map으로 이전 화면에 전달
            /// TabsScreen에서 await Navigator.push()의 결과로 받게 됨
            {
              Filter.gluten: _glutenFreeFilterSet,
              Filter.lactose: _lactoseFreeFilterSet,
              Filter.vegan: _veganFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
            },
          );
        },
        child: Column(
          children: [
            FilterSwitchListTile(
              title: 'Gluten-free',
              description: 'Only include gluten-free meals.',
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
            ),
            FilterSwitchListTile(
              title: 'Lactose-free',
              description: 'Only include lactose-free meals.',
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
            ),
            FilterSwitchListTile(
              title: 'Vegan',
              description: 'Only include vegan meals.',
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
            ),
            FilterSwitchListTile(
              title: 'Vegetarian',
              description: 'Only include vegetarian meals.',
              value: _vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
