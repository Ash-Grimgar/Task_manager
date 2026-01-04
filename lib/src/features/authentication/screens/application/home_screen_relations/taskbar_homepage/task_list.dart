import 'package:flutter/material.dart';

import '../../../../models/task_model.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final ValueChanged<Task> onTaskComplete;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onTaskComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Text('No tasks for today 🎉', style: TextStyle(fontSize: 16)),
      );
    }

    return Column(
      children: tasks.map((task) {
        return TaskTile(task: task, onComplete: () => onTaskComplete(task));
      }).toList(),
    );
  }
}
