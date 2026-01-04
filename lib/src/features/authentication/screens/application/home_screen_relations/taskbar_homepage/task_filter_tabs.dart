import 'package:flutter/material.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../utils/task_enum.dart';

class TaskFilterTabs extends StatelessWidget {
  final TaskFilter selected;
  final ValueChanged<TaskFilter> onChanged;

  const TaskFilterTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: TaskFilter.values.map((filter) {
          final isActive = filter == selected;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(filter),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? tAccentColorLight : tCardBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _label(filter),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isActive ? tWhiteColor : tDarkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _label(TaskFilter filter) {
    switch (filter) {
      case TaskFilter.today:
        return 'Today';
      case TaskFilter.upcoming:
        return 'Upcoming';
      case TaskFilter.overdue:
        return 'Overdue';
    }
  }
}
