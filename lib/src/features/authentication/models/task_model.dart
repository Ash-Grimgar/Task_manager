import '../../../utils/task_enum.dart';

// task_model.dart

class Task {
  final String id;
  final String title;
  final DateTime dueDate;
  final TaskPriority priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });

  bool get isToday {
    final now = DateTime.now();
    return dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;
  }

  bool get isUpcoming {
    final now = DateTime.now();
    return dueDate.isAfter(now) && !isToday;
  }

  bool get isOverdue {
    final now = DateTime.now();
    return dueDate.isBefore(now) && !isToday && !isCompleted;
  }
}
