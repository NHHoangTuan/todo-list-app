import 'package:flutter/material.dart';

class UpcomingTodoScreen extends StatelessWidget {
  const UpcomingTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: const Text('Upcoming Tasks'),
      ),
      body: const Center(
        child: Text('Upcoming todo!'),
      ),
    );
  }
}
