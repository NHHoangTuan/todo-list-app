import 'package:flutter/material.dart';

class UpcomingTodoScreen extends StatelessWidget {
  const UpcomingTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body: const Center(
        child: Text('Upcoming todo!'),
      ),
    );
  }
}
