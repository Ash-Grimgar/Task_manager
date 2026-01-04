import 'package:flutter/material.dart';
import 'package:wind_main/src/features/authentication/screens/application/home_screen_relations/taskbar_homepage/task_list.dart';

import '../../../../../../utils/task_enum.dart';
import '../../../../models/task_model.dart';
import 'header.dart';
import 'today_summary_card.dart';
import 'task_filter_tabs.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // ✅ REQUIRED: filter state lives here
  TaskFilter selectedFilter = TaskFilter.today;
  List<Task> todayTasks = [
    Task(
      id: '1',
      title: 'Build task homepage',
      dueDate: DateTime.now(),
      priority: TaskPriority.high,
    ),
    Task(
      id: '2',
      title: 'Drink water',
      dueDate: DateTime.now(),
      priority: TaskPriority.low,
    ),
  ];

  // 2. HANDLE COMPLETION
  void completeTask(Task task) {
    setState(() {
      todayTasks.remove(task);
    });
  }

  List<Task> get visibleTasks {
    switch (selectedFilter) {
      case TaskFilter.today:
        return todayTasks.where((t) => t.isToday).toList();
      case TaskFilter.upcoming:
        return todayTasks.where((t) => t.isUpcoming).toList();
      case TaskFilter.overdue:
        return todayTasks.where((t) => t.isOverdue).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            TaskHeader(),
            const SizedBox(height: 40),
            TodaySummaryCard(),
            const SizedBox(height: 40),
            // ✅ FILTER TABS WIRED CORRECTLY
            TaskFilterTabs(
              selected: selectedFilter,
              onChanged: (filter) {
                setState(() {
                  selectedFilter = filter;
                });
              },
            ),
            const SizedBox(height: 40),
            Expanded(
              child: TaskList(
                tasks: visibleTasks,
                onTaskComplete: completeTask,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
