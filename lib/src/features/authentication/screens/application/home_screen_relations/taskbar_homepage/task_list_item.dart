import 'package:flutter/material.dart';
import '../../../../models/task_model.dart';
import '../../../../../../constants/colors.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onComplete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tCardBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onComplete,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: tAccentColorLight, width: 2),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              task.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
