import 'package:flutter/material.dart';

class TodayTodoScreen extends StatelessWidget {
  const TodayTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: const Text('Today Tasks'),
      ),
      body: const Center(
        child: Text('Today todo!'),
      ),
    );
  }
}
