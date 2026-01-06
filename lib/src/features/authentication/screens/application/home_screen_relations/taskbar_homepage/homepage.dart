import 'package:flutter/material.dart';
import 'package:wind_main/src/features/authentication/screens/application/home_screen_relations/taskbar_homepage/task_list_item.dart';
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
  TaskFilter selectedFilter = TaskFilter.today;

  final List<Task> todayTasks = [
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

  void completeTask(Task task) {
    setState(() {
      task.isCompleted = true;
      task.completedAt = DateTime.now();
    });
  }

  List<Task> get visibleTasks {
    final now = DateTime.now();

    return todayTasks.where((task) {
      if (task.isCompleted) return false;

      switch (selectedFilter) {
        case TaskFilter.today:
          return task.isToday;
        case TaskFilter.upcoming:
          return task.isUpcoming;
        case TaskFilter.overdue:
          return task.isOverdue;
      }
   return false;
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// HEADER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TaskHeader(),
              ),
            ),

            /// SUMMARY
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: TodaySummaryCard(),
              ),
            ),

            /// FILTER TABS
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: TaskFilterTabs(
                  selected: selectedFilter,
                  onChanged: (filter) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                ),
              ),
            ),

            /// TASK LIST
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final task = visibleTasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TaskListItem(
                        task: task,
                        onComplete: () => completeTask(task),
                      ),
                    );
                  },
                  childCount: visibleTasks.length,
                ),
              ),
            ),

            /// BOTTOM SPACE (breathing room)
            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
