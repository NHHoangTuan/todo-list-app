import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: const Text('TODO List'),
      ),
      body: const Center(
        child: Text('Welcome to TODO List App!'),
      ),
    );
  }
}
