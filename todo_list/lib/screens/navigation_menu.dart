import 'package:flutter/material.dart';
import 'package:todo_list/screens/home_screen.dart';
import 'package:todo_list/screens/today_todos_screen.dart';
import 'package:todo_list/screens/upcoming_todos_screen.dart';
import 'package:todo_list/screens/search_screen.dart';
import 'package:todo_list/screens/all_todos_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  // Danh sách các màn hình tương ứng với mỗi tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const AllTodoScreen(),
    const TodayTodoScreen(),
    const UpcomingTodoScreen(),
    const SearchTodoScreen(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
        child: NavigationBar(
          backgroundColor: Colors.amber[100],
          indicatorColor: Colors.blue[50],
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onDestinationSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'All',
            ),
            NavigationDestination(
              icon: Icon(Icons.today),
              label: 'Today',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month),
              label: 'Upcoming',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}
