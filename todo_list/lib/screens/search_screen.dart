import 'package:flutter/material.dart';

class SearchTodoScreen extends StatelessWidget {
  const SearchTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body: const Center(
        child: Text('Search todo!'),
      ),
    );
  }
}
