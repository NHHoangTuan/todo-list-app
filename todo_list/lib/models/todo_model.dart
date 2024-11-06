// // lib/models/todo.dart
// import 'package:uuid/uuid.dart';

// class Todo {
//   final String id;
//   final String title;
//   final String? description;
//   final DateTime? deadline;
//   bool isCompleted;

//   Todo({
//     required this.title,
//     this.description,
//     this.deadline,
//     this.isCompleted = false,
//   }) : id = const Uuid().v4();

// }

// lib/models/todo_model.dart
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  DateTime? deadline;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    this.isCompleted = false,
    required this.createdAt,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? deadline,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
