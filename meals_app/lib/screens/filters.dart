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
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // 상태가 변화할테니 var로 선언
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _veganFilterSet = false;
  var _vegetarianFilterSet = false;

  @override
  Widget build(BuildContext context) {
    // 새로운 화면이므로 `Scaffold` 사용
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        // 사용자가 화면을 나가려고할 때 마다 작동한다
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) return;
          Navigator.of(context).pop(
            // map 형태로 반환
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
