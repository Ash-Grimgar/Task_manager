import 'package:flutter/material.dart';
import '../../../../models/task_model.dart';
import '../../../../../../utils/task_enum.dart';
import 'edit_task_sheet.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onComplete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onComplete,
  });

  Color _priorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green.withOpacity(0.15);
      case TaskPriority.medium:
        return Colors.orange.withOpacity(0.15);
      case TaskPriority.high:
        return Colors.red.withOpacity(0.15);
    }
  }

  Color _priorityBorder(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => EditTaskSheet(task: task),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _priorityColor(task.priority),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _priorityBorder(task.priority).withOpacity(0.6),
          ),
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
                  border: Border.all(
                    color: _priorityBorder(task.priority),
                    width: 2,
                  ),
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
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
