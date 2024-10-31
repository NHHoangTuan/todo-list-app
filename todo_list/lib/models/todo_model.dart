// lib/models/todo.dart
import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final String? description;
  final DateTime deadline;
  bool isCompleted;

  Todo({
    required this.title,
    this.description,
    required this.deadline,
    this.isCompleted = false,
  }) : id = const Uuid().v4();

  // Convert to và from Map để lưu vào storage
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'deadline': deadline.toIso8601String(),
  //     'isCompleted': isCompleted,
  //   };
  // }

  // factory Todo.fromMap(Map<String, dynamic> map) {
  //   return Todo(
  //     id: map['id'],
  //     title: map['title'],
  //     description: map['description'],
  //     deadline: DateTime.parse(map['deadline']),
  //     isCompleted: map['isCompleted'],
  //   );
  // }
}
