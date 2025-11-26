import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const DoodleTaskManagerApp());
}

class DoodleTaskManagerApp extends StatelessWidget {
  const DoodleTaskManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doodle Task Manager',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF7F0), // Pale beige
        fontFamily: 'Nunito',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
      home: const TodayViewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ----- DATA MODELS -----
enum Priority { low, medium, high }

class Task {
  final String title;
  final String dueTime;
  final Priority priority;
  final double progress; // 0.0 to 1.0

  Task({
    required this.title,
    required this.dueTime,
    required this.priority,
    required this.progress,
  });
}

// ----- TODAY VIEW SCREEN -----
class TodayViewScreen extends StatefulWidget {
  const TodayViewScreen({Key? key}) : super(key: key);

  @override
  State<TodayViewScreen> createState() => _TodayViewScreenState();
}

class _TodayViewScreenState extends State<TodayViewScreen>
    with SingleTickerProviderStateMixin {
  final List<String> categories = [
    'All',
    'Work',
    'Personal',
    'Overdue',
    'Completed',
  ];

  String selectedCategory = 'All';

  final List<Task> tasks = [
    Task(
      title: 'Finish doodle illustration',
      dueTime: 'Today, 4:00 PM',
      priority: Priority.medium,
      progress: 0.6,
    ),
    Task(
      title: 'Call with team',
      dueTime: 'Today, 2:30 PM',
      priority: Priority.high,
      progress: 1.0,
    ),
    Task(
      title: 'Plan weekend picnic',
      dueTime: 'Tomorrow',
      priority: Priority.low,
      progress: 0.2,
    ),
    Task(
      title: 'Submit project report',
      dueTime: 'Overdue',
      priority: Priority.high,
      progress: 0.4,
    ),
    Task(
      title: 'Read new design trends',
      dueTime: 'Today, 6:00 PM',
      priority: Priority.low,
      progress: 0.0,
    ),
  ];

  int get completedTasks =>
      tasks.where((task) => task.progress >= 1.0).length;

  int get totalTasks => tasks.length;

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  List<Task> get filteredTasks {
    if (selectedCategory == 'All') {
      return tasks;
    } else if (selectedCategory == 'Overdue') {
      return tasks
          .where((t) => t.dueTime.toLowerCase().contains('overdue'))
          .toList();
    } else if (selectedCategory == 'Completed') {
      return tasks.where((t) => t.progress >= 1.0).toList();
    } else {
      return tasks
          .where((t) =>
          t.title.toLowerCase().contains(selectedCategory.toLowerCase()))
          .toList();
    }
  }

  // Soft pastel colors for priority backgrounds
  Color priorityBackgroundColor(Priority p) {
    switch (p) {
      case Priority.low:
        return const Color(0xFFD0F0C0); // Mint green pastel
      case Priority.medium:
        return const Color(0xFFD8C1FF); // Soft purple pastel
      case Priority.high:
        return const Color(0xFFFFD6D6); // Soft coral pastel
    }
  }

  Color priorityDotColor(Priority p) {
    switch (p) {
      case Priority.low:
        return const Color(0xFF3EB489); // Mint green
      case Priority.medium:
        return const Color(0xFF7B5FFF); // Purple
      case Priority.high:
        return const Color(0xFFFB7185); // Coral
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Floating action button with bounce animation
      floatingActionButton: BounceFloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const AddTaskModal(),
          );
        },
      ),
      bottomNavigationBar: const DoodleBottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with greeting, avatar and doodle sun
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Good Morning, George 👋',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const DoodleSunIcon(size: 36),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 22,
                    backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=5'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Progress summary card
              ProgressCard(
                completed: completedTasks,
                total: totalTasks,
                backgroundColor: const Color(0xFFD8C1FF), // pastel purple
              ),
              const SizedBox(height: 18),

              // Category chips row
              CategoryChipList(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: _onCategorySelected,
              ),
              const SizedBox(height: 20),

              // Task list
              Expanded(
                child: filteredTasks.isEmpty
                    ? Center(
                  child: Text(
                    'No tasks here 😌',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      fontFamily: 'Nunito',
                    ),
                  ),
                )
                    : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredTasks.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return TaskCard(
                      task: task,
                      backgroundColor:
                      priorityBackgroundColor(task.priority),
                      dotColor: priorityDotColor(task.priority),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----- PROGRESS CARD -----
class ProgressCard extends StatelessWidget {
  final int completed;
  final int total;
  final Color backgroundColor;

  const ProgressCard({
    Key? key,
    required this.completed,
    required this.total,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = total == 0 ? 0 : completed / total;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColor.withOpacity(0.9),
            backgroundColor.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        children: [
          CustomPaint(
            painter: DoodleProgressRingPainter(progress),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Center(
                child: Text(
                  '${(progress * 100).round()}%',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.95),
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$completed of $total tasks done',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.95),
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'You’re doing amazing today 💪',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Painter for doodle style circular progress ring
class DoodleProgressRingPainter extends CustomPainter {
  final double progress;

  DoodleProgressRingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 8.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paintBackground = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintProgress = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.white70],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw rough circle with "doodle" effect (hand-drawn)
    final path = Path();
    const wiggle = 3.0;
    for (double i = 0; i < 360; i += 10) {
      final angle = i * 3.14159 / 180;
      final x = center.dx + radius * cos(angle) + (wiggle * (i % 20 == 0 ? 1 : -1));
      final y = center.dy + radius * sin(angle) + (wiggle * ((i + 10) % 20 == 0 ? -1 : 1));
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paintBackground);

    // Progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = -3.14159 / 2;
    final sweepAngle = 2 * 3.14159 * progress;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paintProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ----- CATEGORY CHIP LIST -----
class CategoryChipList extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final void Function(String) onCategorySelected;

  const CategoryChipList({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  // Mapping category to doodle icon widget
  Widget categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'all':
        return const DoodleBoxIcon();
      case 'work':
        return const DoodleBriefcaseIcon();
      case 'personal':
        return const DoodleHeartIcon();
      case 'overdue':
        return const DoodleClockIcon();
      case 'completed':
        return const DoodleCheckIcon();
      default:
        return const SizedBox.shrink();
    }
  }

  LinearGradient chipGradient(bool selected) {
    if (selected) {
      return const LinearGradient(
        colors: [Color(0xFF7B5FFF), Color(0xFFD8C1FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFFF7F4FF), Color(0xFFEDEAFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = category == selectedCategory;
          return InkWell(
            onTap: () => onCategorySelected(category),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                gradient: chipGradient(selected),
                borderRadius: BorderRadius.circular(24),
                boxShadow: selected
                    ? [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
                    : [],
              ),
              child: Row(
                children: [
                  categoryIcon(category),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: selected
                          ? Colors.white
                          : Colors.deepPurple.shade300,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ----- TASK CARD -----
class TaskCard extends StatelessWidget {
  final Task task;
  final Color backgroundColor;
  final Color dotColor;

  const TaskCard({
    Key? key,
    required this.task,
    required this.backgroundColor,
    required this.dotColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(22),
      color: backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          // Navigate to task detail screen (not implemented here)
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and due time row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Priority dot
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: dotColor.withOpacity(0.7),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      const DoodleClockIcon(size: 16),
                      const SizedBox(width: 4),
                      Text(
                        task.dueTime,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Doodle style progress bar
              DoodleProgressBar(progress: task.progress),
            ],
          ),
        ),
      ),
    );
  }
}

// ----- DOODLE STYLE PROGRESS BAR -----
class DoodleProgressBar extends StatelessWidget {
  final double progress;

  const DoodleProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barHeight = 12.0;
    final barWidth = MediaQuery.of(context).size.width - 80;

    return CustomPaint(
      size: Size(barWidth, barHeight),
      painter: _DoodleProgressBarPainter(progress),
    );
  }
}

class _DoodleProgressBarPainter extends CustomPainter {
  final double progress;

  _DoodleProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paintBg = Paint()
      ..color = const Color(0xFFE7E0FF)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.5;

    final paintProgress = Paint()
      ..color = const Color(0xFF7B5FFF)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.5;

    final radius = 8.0;

    final bgRect = RRect.fromLTRBR(
        0, 0, size.width, size.height, Radius.circular(radius));
    canvas.drawRRect(bgRect, paintBg);

    final progressWidth = size.width * progress;
    final progressRect = RRect.fromLTRBR(
        0, 0, progressWidth, size.height, Radius.circular(radius));
    canvas.drawRRect(progressRect, paintProgress);

    // Hand-drawn zigzag top edge for doodle effect
    final path = Path();
    const zigzagHeight = 3.5;
    const zigzagWidth = 6.0;

    path.moveTo(0, 0);
    double x = 0;
    bool up = true;
    while (x < progressWidth) {
      path.lineTo(x, up ? -zigzagHeight : 0);
      x += zigzagWidth / 2;
      up = !up;
    }
    path.lineTo(progressWidth, 0);
    path.lineTo(progressWidth, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paintZigzag = Paint()
      ..color = const Color(0xFF5E49B7)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paintZigzag);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ----- FLOATING ACTION BUTTON WITH BOUNCE -----
class BounceFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;

  const BounceFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  State<BounceFloatingActionButton> createState() =>
      _BounceFloatingActionButtonState();
}

class _BounceFloatingActionButtonState
    extends State<BounceFloatingActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 0.15,
    );
    final curve =
    CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _animation = Tween<double>(begin: 1, end: 1.15).animate(curve);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: FloatingActionButton(
        elevation: 6,
        backgroundColor: const Color(0xFFD8F3DC), // pastel mint green
        onPressed: _onTap,
        child: const DoodlePlusIcon(size: 28),
        tooltip: 'Add Task',
      ),
    );
  }
}

// ----- DOODLE ICONS (simplified hand-drawn style) -----
class DoodleSunIcon extends StatelessWidget {
  final double size;
  const DoodleSunIcon({Key? key, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DoodleSunPainter(),
    );
  }
}

class _DoodleSunPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = const Color(0xFFFFD97D)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFFFFC947)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 4;

    canvas.drawCircle(center, radius, circlePaint);
    canvas.drawCircle(center, radius, strokePaint);

    final rayPaint = Paint()
      ..color = const Color(0xFFFFC947)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final rayLength = size.width / 3;
    for (int i = 0; i < 8; i++) {
      final angle = (3.14159 / 4) * i;
      final start = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      final end = Offset(
        center.dx + (radius + rayLength) * cos(angle),
        center.dy + (radius + rayLength) * sin(angle),
      );
      canvas.drawLine(start, end, rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Doodle style plus icon for FAB
class DoodlePlusIcon extends StatelessWidget {
  final double size;
  const DoodlePlusIcon({Key? key, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DoodlePlusPainter(),
    );
  }
}

class _DoodlePlusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3EB489)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final length = size.width / 3;

    canvas.drawLine(
      Offset(center.dx, center.dy - length),
      Offset(center.dx, center.dy + length),
      paint,
    );

    canvas.drawLine(
      Offset(center.dx - length, center.dy),
      Offset(center.dx + length, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Doodle style clock icon
class DoodleClockIcon extends StatelessWidget {
  final double size;
  const DoodleClockIcon({Key? key, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DoodleClockPainter(),
    );
  }
}

class _DoodleClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF7B5FFF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;

    canvas.drawCircle(center, radius, strokePaint);

    // Hour hand
    canvas.drawLine(center, Offset(center.dx, center.dy - radius / 1.8), strokePaint);
    // Minute hand
    canvas.drawLine(center, Offset(center.dx + radius / 1.5, center.dy), strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Doodle style check icon
class DoodleCheckIcon extends StatelessWidget {
  final double size;
  const DoodleCheckIcon({Key? key, this.size = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DoodleCheckPainter(),
    );
  }
}

class _DoodleCheckPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3EB489)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.55);
    path.lineTo(size.width * 0.45, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Doodle style box icon (for "All")
class DoodleBoxIcon extends StatelessWidget {
  final double size;
  const DoodleBoxIcon({Key? key, this.size = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DoodleBoxPainter(),
    );
  }
}

class _DoodleBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7B5FFF)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Doodle briefcase icon (for "Work")
class DoodleBriefcaseIcon extends StatelessWidget {
  final double size;
  const DoodleBriefcaseIcon({Key? key, this.size = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DoodleBriefcasePainter(),
    );
  }
}

class _DoodleBriefcasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7B5FFF)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final bodyRect = Rect.fromLTWH(2, size.height * 0.3, size.width - 4, size.height * 0.55);
    canvas.drawRRect(RRect.fromRectAndRadius(bodyRect, const Radius.circular(6)), paint);

    final handlePath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.3)
      ..lineTo(size.width * 0.25, size.height * 0.15)
      ..lineTo(size.width * 0.75, size.height * 0.15)
      ..lineTo(size.width * 0.75, size.height * 0.3);

    canvas.drawPath(handlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Doodle heart icon (for "Personal")
class DoodleHeartIcon extends StatelessWidget {
  final double size;
  const DoodleHeartIcon({Key? key, this.size = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DoodleHeartPainter(),
    );
  }
}

class _DoodleHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFB7185)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width / 2, size.height * 0.85);
    path.cubicTo(
      size.width * 0.1,
      size.height * 0.55,
      size.width * 0.25,
      size.height * 0.15,
      size.width / 2,
      size.height * 0.35,
    );
    path.cubicTo(
      size.width * 0.75,
      size.height * 0.15,
      size.width * 0.9,
      size.height * 0.55,
      size.width / 2,
      size.height * 0.85,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ----- ADD TASK MODAL -----
class AddTaskModal extends StatefulWidget {
  const AddTaskModal({Key? key}) : super(key: key);

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';
  DateTime? dueDate;
  Priority priority = Priority.medium;
  String category = 'Work';

  final List<String> categories = [
    'Work',
    'Personal',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFAF7F0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Let's add something new 🪄",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _LabeledTextField(
                    label: 'Title',
                    icon: const DoodleBoxIcon(size: 20),
                    onChanged: (val) => title = val,
                    validator: (val) =>
                    val == null || val.isEmpty ? 'Enter title' : null,
                  ),
                  const SizedBox(height: 16),
                  _LabeledTextField(
                    label: 'Description',
                    icon: const DoodleHeartIcon(size: 20),
                    maxLines: 3,
                    onChanged: (val) => description = val,
                  ),
                  const SizedBox(height: 16),
                  _LabeledDatePicker(
                    label: 'Due Date',
                    icon: const DoodleClockIcon(size: 20),
                    selectedDate: dueDate,
                    onDatePicked: (date) {
                      setState(() {
                        dueDate = date;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _LabeledDropdown<Priority>(
                    label: 'Priority',
                    icon: const DoodleStarIcon(size: 20),
                    value: priority,
                    items: Priority.values,
                    itemBuilder: (p) => Text(p.name[0].toUpperCase() + p.name.substring(1)),
                    onChanged: (p) {
                      if (p != null) {
                        setState(() {
                          priority = p;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _LabeledDropdown<String>(
                    label: 'Category',
                    icon: const DoodleFolderIcon(size: 20),
                    value: category,
                    items: categories,
                    itemBuilder: (categoryName) => Text(categoryName),
                    onChanged: (c) {
                      if (c != null) {
                        setState(() {
                          category = c;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 14)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFFFCBD6),
                        ),
                        elevation: MaterialStateProperty.all(6),
                        shadowColor:
                        MaterialStateProperty.all(Colors.pinkAccent.shade100),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pop();
                          // Save task logic here
                        }
                      },
                      child: const Text(
                        'Add Task',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Reusable labeled text field with doodle icon
class _LabeledTextField extends StatelessWidget {
  final String label;
  final Widget icon;
  final int maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const _LabeledTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          maxLines: maxLines,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.deepPurple.shade300),
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable labeled date picker with doodle icon
class _LabeledDatePicker extends StatelessWidget {
  final String label;
  final Widget icon;
  final DateTime? selectedDate;
  final void Function(DateTime) onDatePicked;

  const _LabeledDatePicker({
    Key? key,
    required this.label,
    required this.icon,
    required this.selectedDate,
    required this.onDatePicked,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF7B5FFF),
            onPrimary: Colors.white,
            onSurface: Colors.deepPurple,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF7B5FFF),
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      onDatePicked(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = selectedDate == null
        ? 'Select date'
        : '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _selectDate(context),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              dateText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color:
                selectedDate == null ? Colors.grey.shade500 : Colors.black87,
                fontFamily: 'Nunito',
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable labeled dropdown with doodle icon
class _LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final Widget icon;
  final T value;
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final void Function(T?) onChanged;

  const _LabeledDropdown({
    Key? key,
    required this.label,
    required this.icon,
    required this.value,
    required this.items,
    required this.itemBuilder,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              items: items
                  .map(
                    (e) => DropdownMenuItem<T>(
                  value: e,
                  child: itemBuilder(e),
                ),
              )
                  .toList(),
              onChanged: onChanged,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Nunito',
                fontSize: 15,
              ),
              iconEnabledColor: const Color(0xFF7B5FFF),
            ),
          ),
        ),
      ],
    );
  }
}

// ----- ADDITIONAL DOODLE ICONS FOR ADD TASK MODAL -----
class DoodleStarIcon extends StatelessWidget {
  final double size;
  const DoodleStarIcon({Key? key, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _DoodleStarPainter());
  }
}

class _DoodleStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFC0CB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.2;

    for (int i = 0; i < 5; i++) {
      final angle = (i * 72 - 90) * 3.14159 / 180;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DoodleFolderIcon extends StatelessWidget {
  final double size;
  const DoodleFolderIcon({Key? key, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _DoodleFolderPainter());
  }
}

class _DoodleFolderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7B5FFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path();
    path.moveTo(2, size.height * 0.6);
    path.lineTo(size.width - 2, size.height * 0.6);
    path.lineTo(size.width - 2, size.height - 2);
    path.lineTo(2, size.height - 2);
    path.close();

    final tab = Path();
    tab.moveTo(2, size.height * 0.6);
    tab.lineTo(size.width * 0.3, size.height * 0.3);
    tab.lineTo(size.width * 0.7, size.height * 0.3);
    tab.lineTo(size.width - 2, size.height * 0.6);

    canvas.drawPath(path, paint);
    canvas.drawPath(tab, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ----- BOTTOM NAVIGATION BAR -----
class DoodleBottomNavBar extends StatefulWidget {
  const DoodleBottomNavBar({Key? key}) : super(key: key);

  @override
  State<DoodleBottomNavBar> createState() => _DoodleBottomNavBarState();
}

class _DoodleBottomNavBarState extends State<DoodleBottomNavBar> {
  int selectedIndex = 0;

  final List<String> labels = ['Home', 'Calendar', 'Projects', 'Profile'];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // Navigation logic can be added here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.shade100.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _DoodleNavBarItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: selectedIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          _DoodleNavBarItem(
            icon: Icons.calendar_today_outlined,
            label: 'Calendar',
            selected: selectedIndex == 1,
            onTap: () => _onItemTapped(1),
          ),
          _DoodleNavBarItem(
            icon: Icons.folder_open_outlined,
            label: 'Projects',
            selected: selectedIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          _DoodleNavBarItem(
            icon: Icons.person_outline,
            label: 'Profile',
            selected: selectedIndex == 3,
            onTap: () => _onItemTapped(3),
          ),
        ],
      ),
    );
  }
}

class _DoodleNavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DoodleNavBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF7B5FFF) : Colors.grey.shade400;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26,
              color: color,
              semanticLabel: label,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
                fontFamily: 'Nunito',
              ),
            )
          ],
        ),
      ),
    );
  }
}