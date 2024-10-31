import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/screens/navigation_menu.dart';
import 'providers/todo_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO List App',
        theme: AppTheme.lightTheme,
        home: const NavigationMenu(),
      ),
    );
  }
}
