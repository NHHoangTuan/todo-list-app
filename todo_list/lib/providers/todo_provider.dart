import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:hive/hive.dart';

import '../services/notification_service.dart';

// lib/providers/todo_provider.dart
class TodoProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  late Box<Todo> _box;
  List<Todo> _todos = [];

  TodoProvider() {
    _box = Hive.box<Todo>('todos');
    _loadTodos();
  }

  List<Todo> get todos => _todos;

  void _loadTodos() {
    _todos = _box.values.where((todo) => !todo.isCompleted).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    notifyListeners();
  }

  Future<void> add(Todo todo) async {
    await _box.put(todo.id, todo);
    if (todo.deadline != null) {
      await _notificationService.scheduleNotification(
        todo.id,
        todo.title,
        todo.description ?? '',
        todo.deadline!,
      );
    }
    _loadTodos();
  }

  Future<void> remove(Todo todo) async {
    await _box.delete(todo.id);
    await _notificationService.cancelNotification(todo.id);
    _loadTodos();
  }

  Future<void> toggleDone(Todo todo) async {
    todo.isCompleted = !todo.isCompleted;
    await _box.put(todo.id, todo);
    if (todo.isCompleted) {
      await _notificationService.cancelNotification(todo.id);
    }
    _loadTodos();
  }

  void updateTodoTemp(Todo updatedTodo) {
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      notifyListeners();
    }
  }

// Get todos for today
  List<Todo> get todayTodos {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return _todos.where((todo) {
      if (todo.deadline == null) return false;
      final todoDate = DateTime(
          todo.deadline!.year, todo.deadline!.month, todo.deadline!.day);
      return todoDate.isAtSameMomentAs(today);
    }).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

// Get upcoming todos (future days)
  List<Todo> get upcomingTodos {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return _todos.where((todo) {
      if (todo.deadline == null) return false;
      final todoDate = DateTime(
          todo.deadline!.year, todo.deadline!.month, todo.deadline!.day);
      return todoDate.isAfter(today);
    }).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }
}
