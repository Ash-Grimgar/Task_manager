import 'package:flutter/material.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../utils/task_enum.dart';
import '../../../../models/task_model.dart';


class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onComplete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tCardBgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _priorityDot(task.priority),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              task.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          GestureDetector(
            onTap: onComplete,
            child: const Icon(
              Icons.check_circle_outline,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _priorityDot(TaskPriority priority) {
    Color color;

    switch (priority) {
      case TaskPriority.low:
        color = Colors.green;
        break;
      case TaskPriority.medium:
        color = Colors.orange;
        break;
      case TaskPriority.high:
        color = Colors.red;
        break;
    }

    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
