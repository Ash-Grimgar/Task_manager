import 'package:flutter/material.dart';
import '../../../../models/task_model.dart';

class HistoryListItem extends StatelessWidget {
  final Task task;

  const HistoryListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          if (task.completedAt != null) ...[
            const SizedBox(height: 6),
            Text(
              'Completed on ${task.completedAt!.day}/${task.completedAt!.month}',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
