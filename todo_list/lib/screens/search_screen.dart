import 'package:flutter/material.dart';

class SearchTodoScreen extends StatelessWidget {
  const SearchTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: const Text('Search'),
      ),
      body: const Center(
        child: Text('Search todo!'),
      ),
    );
  }
}
