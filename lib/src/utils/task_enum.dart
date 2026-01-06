import 'package:hive/hive.dart';

part 'task_enum.g.dart';

@HiveType(typeId: 1)
enum TaskPriority {
  @HiveField(0)
  low,

  @HiveField(1)
  medium,

  @HiveField(2)
  high,


}
enum TaskFilter { today, upcoming, overdue }

