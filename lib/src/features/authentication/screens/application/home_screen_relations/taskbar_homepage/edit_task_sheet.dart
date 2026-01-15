import 'package:flutter/material.dart';

import '../../../../models/task_model.dart';
import '../../../../../../utils/task_enum.dart';

class EditTaskSheet extends StatefulWidget {
  final Task task;

  const EditTaskSheet({
    super.key,
    required this.task,
  });

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  late final TextEditingController _titleController;
  late TaskPriority priority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    priority = widget.task.priority;
  }

  void saveChanges() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    widget.task
      ..title = title
      ..priority = priority
      ..save();

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
              'Edit Task',
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
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
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
                onPressed: saveChanges,
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
