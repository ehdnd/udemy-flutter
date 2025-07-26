import 'package:flutter/material.dart';

class FilterSwitchListTile extends StatelessWidget {
  const FilterSwitchListTile({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      // 새로운 변수를 받아서 상태 변경
      onChanged: onChanged,
      // 스위치 옆에 label 표시
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      // 메인 레이블 아래에 표시되는 부가 설명
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      // active on 시에 표시될 색상
      activeColor: Theme.of(context).colorScheme.tertiary,
      // 스위치 옆에 표시되는 텍스트 영역의 패딩 설정 ??
      contentPadding: EdgeInsets.only(left: 34, right: 22),
    );
  }
}
