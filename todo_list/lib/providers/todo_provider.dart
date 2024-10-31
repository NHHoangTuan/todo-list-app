import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  // Tạo các biến và phương thức quản lý TODO ở đây sau này

  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

// add a todo
  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

// remove a todo
  void remove(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

// update a todo
  void update(Todo todo) {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    _todos[index] = todo;
    notifyListeners();
  }

// toggle done
  void toggleDone(Todo todo) {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    _todos[index].isCompleted = !todo.isCompleted;
    notifyListeners();
  }

  // get todo for today
  List<Todo> get todayTodos {
    return _todos.where((todo) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      return todo.deadline.isAtSameMomentAs(today);
    }).toList();
  }

  // get upcoming todos
  List<Todo> get upcomingTodos {
    return _todos.where((todo) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      return todo.deadline.isAfter(today);
    }).toList();
  }
}
