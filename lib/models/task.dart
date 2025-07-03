enum TaskStatus { open, complete }

class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  TaskStatus status;
  int priority; // 1 = Low, 2 = Medium, 3 = High

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.status = TaskStatus.open,
    this.priority = 1,
  });
}
