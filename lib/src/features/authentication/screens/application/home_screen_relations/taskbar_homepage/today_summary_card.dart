import 'package:flutter/material.dart';

class TodaySummaryCard extends StatelessWidget {
  final int total;
  final int completed;

  const TodaySummaryCard({
    super.key,
    required this.total,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Progress",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "$completed of $total tasks completed",
            style: const TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF6366F1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
