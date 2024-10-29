import 'package:flutter/material.dart';

class TodayTodoScreen extends StatelessWidget {
  const TodayTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body: const Center(
        child: Text('Today todo!'),
      ),
    );
  }
}
