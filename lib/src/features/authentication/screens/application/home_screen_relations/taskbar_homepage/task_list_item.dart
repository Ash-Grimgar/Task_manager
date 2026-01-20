import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/task_enum.dart';
import '../../../../models/task_model.dart';
import 'edit_task_sheet.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onComplete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onComplete,
  });

  Color getStatusColor() {
    if (task.isOverdue) return Colors.redAccent;
    if (task.isToday) return Colors.orangeAccent;
    return Colors.blueAccent;
  }

  Color getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high:
        return Colors.redAccent;
      case TaskPriority.medium:
        return Colors.amberAccent;
      case TaskPriority.low:
        return Colors.greenAccent;
    }
  }

  String getDueLabel() {
    if (task.isOverdue) return 'Overdue';
    if (task.isToday) return 'Today';
    return 'Upcoming';
  }

  @override
  Widget build(BuildContext context) {
    String getDueDateLabel() {
      final today = DateTime.now();
      final todayOnly = DateTime(today.year, today.month, today.day);
      final dueOnly =
      DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);

      if (dueOnly == todayOnly) return 'Today';
      if (dueOnly == todayOnly.add(const Duration(days: 1))) return 'Tomorrow';
      if (dueOnly.isBefore(todayOnly)) return 'Overdue';

      return '${dueOnly.day}/${dueOnly.month}/${dueOnly.year}';
    }

    final statusColor = getStatusColor();
    final priorityColor = getPriorityColor();

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
          color: const Color(0xFF1E293B), // 🔥 dark slate tile
          borderRadius: BorderRadius.circular(20),
          border: Border(
            left: BorderSide(color: statusColor, width: 4),
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
                  border: Border.all(color: statusColor, width: 2),
                ),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Priority dot
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: priorityColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        getDueLabel(),
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
