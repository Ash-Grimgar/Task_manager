import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../../../utils/task_enum.dart';
import '../../../../models/task_model.dart';

import 'add_task_sheet.dart';
import 'edit_task_sheet.dart';
import 'task_list_item.dart';
import 'header.dart';
import 'today_summary_card.dart';
import 'task_filter_tabs.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Box<Task> taskBox;
  TaskFilter selectedFilter = TaskFilter.today;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<Task>('tasks');
  }

  void completeTask(Task task) {
    task.isCompleted = true;
    task.completedAt = DateTime.now();
    task.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6366F1),
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => AddTaskSheet(
              onTaskCreated: (_) {},
            ),
          );
        },
      ),

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
                    setState(() => selectedFilter = filter);
                  },
                ),
              ),
            ),

            /// TASK LIST
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: ValueListenableBuilder(
                valueListenable: taskBox.listenable(),
                builder: (context, Box<Task> box, _) {
                  final tasks = box.values.toList();

                  final visibleTasks = tasks.where((task) {
                    if (task.isCompleted) return false;

                    switch (selectedFilter) {
                      case TaskFilter.today:
                        return task.isToday;
                      case TaskFilter.upcoming:
                        return task.isUpcoming;
                      case TaskFilter.overdue:
                        return task.isOverdue;
                    }
                  }).toList();

                  if (visibleTasks.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'No tasks yet',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final task = visibleTasks[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => EditTaskSheet(task: task),
                              );
                            },
                            child: TaskListItem(
                              task: task,
                              onComplete: () => completeTask(task),
                            ),
                          ),
                        );
                      },
                      childCount: visibleTasks.length,
                    ),
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
