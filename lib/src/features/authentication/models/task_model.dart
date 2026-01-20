import 'package:hive/hive.dart';
import '../../../utils/task_enum.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  TaskPriority priority;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  DateTime? completedAt;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    this.completedAt,
  });

  // 🔹 Helpers to remove time from dates
  DateTime get _dueDateOnly =>
      DateTime(dueDate.year, dueDate.month, dueDate.day);

  DateTime get _todayOnly {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  // 🔹 Correct logic
  bool get isToday {
    return _dueDateOnly == _todayOnly;
  }

  bool get isUpcoming {
    return _dueDateOnly.isAfter(_todayOnly);
  }

  bool get isOverdue {
    return _dueDateOnly.isBefore(_todayOnly);
  }
}
