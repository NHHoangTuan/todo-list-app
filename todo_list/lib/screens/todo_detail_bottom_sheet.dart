// lib/screens/todo_detail_bottom_sheet.dart
import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../widgets/date_time_card.dart';

void showTodoDetail(BuildContext context, Todo todo) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  if (todo.deadline != null)
                    Flexible(
                      child: DateTimeCard(deadline: todo.deadline!),
                    ),
                  const SizedBox(height: 20),
                  Text(todo.description ?? 'No description'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
