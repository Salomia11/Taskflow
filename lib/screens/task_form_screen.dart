import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  TaskFormScreenState createState() => TaskFormScreenState();
}

class TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();
  int _priority = 1;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _priority = widget.task!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Task' : 'New Task')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (val) => _title = val ?? '',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (val) => _description = val ?? '',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<int>(
                value: _priority,
                items: const [
                  DropdownMenuItem<int>(value: 1, child: Text('Low')),
                  DropdownMenuItem<int>(value: 2, child: Text('Medium')),
                  DropdownMenuItem<int>(value: 3, child: Text('High')),
                ],
                decoration: const InputDecoration(labelText: 'Priority'),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _priority = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEditing ? 'Update' : 'Add Task'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newTask = Task(
                      id: isEditing ? widget.task!.id : Uuid().v4(),
                      title: _title,
                      description: _description,
                      dueDate: _dueDate,
                      priority: _priority,
                    );

                    if (isEditing) {
                      taskProvider.updateTask(newTask);
                    } else {
                      taskProvider.addTask(newTask);
                    }

                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
