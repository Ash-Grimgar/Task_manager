import 'package:flutter/material.dart';
import '../../../../models/task_model.dart';
import '../../../../../../utils/task_enum.dart';

class AddTaskSheet extends StatefulWidget {
  final void Function(Task task) onTaskCreated;

  const AddTaskSheet({
    super.key,
    required this.onTaskCreated,
  });

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final TextEditingController _titleController = TextEditingController();

  TaskPriority priority = TaskPriority.medium;
  DateTime dueDate = DateTime.now();

  Future<void> pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (picked != null) {
      setState(() => dueDate = picked);
    }
  }

  void createTask() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      dueDate: dueDate,
      priority: priority,
    );

    widget.onTaskCreated(task);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF0F172A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Task title',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),

            const SizedBox(height: 16),

            /// DUE DATE PICKER
            InkWell(
              onTap: pickDueDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Due: ${dueDate.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<TaskPriority>(
              value: priority,
              dropdownColor: const Color(0xFF1E293B),
              decoration: const InputDecoration(
                labelText: 'Priority',
                labelStyle: TextStyle(color: Colors.white),
              ),
              items: TaskPriority.values.map((p) {
                return DropdownMenuItem(
                  value: p,
                  child: Text(
                    p.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => priority = value);
                }
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: createTask,
                child: const Text('Create Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
