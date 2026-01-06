import 'package:hive/hive.dart';
import '../../../utils/task_enum.dart';

part "task_model.g.dart";

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime dueDate;

  @HiveField(3)
  final TaskPriority priority;

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
}
