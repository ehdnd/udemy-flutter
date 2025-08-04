import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/filter_switch_list_tile.dart';

/// 유저 인풋 State를 다뤄야하므로 StatefulWidget 사용
/// 하지만 이제는 Provider를 사용하므로 ConsumerStatefulWidget 사용
/// -> 하지만 이제는 Provider 로 관리하므로 ConsumerWidget 사용
class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 변화가 있을 때 마다 build 메서드 실행
    /// watch() 메서드 사용
    final activeFilters = ref.watch(filterProvider);

    // 새로운 화면이므로 `Scaffold` 사용
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // PopScope 사용 안함 -> 이제는 Provider 로 관리하므로 삭제
      body: Column(
        children: [
          FilterSwitchListTile(
            title: 'Gluten-free',
            description: 'Only include gluten-free meals.',
            value: activeFilters[Filter.gluten]!,
            onChanged: (isChecked) => ref
                .read(filterProvider.notifier)
                .setFilter(Filter.gluten, isChecked),
          ),
          FilterSwitchListTile(
            title: 'Lactose-free',
            description: 'Only include lactose-free meals.',
            value: activeFilters[Filter.lactose]!,
            onChanged: (isChecked) => ref
                .read(filterProvider.notifier)
                .setFilter(Filter.lactose, isChecked),
          ),
          FilterSwitchListTile(
            title: 'Vegan',
            description: 'Only include vegan meals.',
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) => ref
                .read(filterProvider.notifier)
                .setFilter(Filter.vegan, isChecked),
          ),
          FilterSwitchListTile(
            title: 'Vegetarian',
            description: 'Only include vegetarian meals.',
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) => ref
                .read(filterProvider.notifier)
                .setFilter(Filter.vegetarian, isChecked),
          ),
        ],
      ),
    );
  }
}
