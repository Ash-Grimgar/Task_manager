import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayProgressBar extends StatelessWidget {
  final int completed;
  final int total;

  const TodayProgressBar({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$completed of $total completed',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: Container(
            height: 7,
            decoration: const BoxDecoration(
              color: Color(0xFF334155),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF22D3EE),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
