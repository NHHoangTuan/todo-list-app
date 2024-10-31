// import 'package:flutter/material.dart';
// import '../providers/todo_provider.dart';
// import 'package:provider/provider.dart';

// class AllTodoScreen extends StatefulWidget {
//   const AllTodoScreen({super.key});

//   @override
//   _AllTodoScreenState createState() => _AllTodoScreenState();
// }

// class _AllTodoScreenState extends State<AllTodoScreen> {
//   final List<Map<String, dynamic>> _todos = [
//     {
//       'title': 'Buy groceries',
//       'description': 'Milk, Bread, Eggs',
//       'time': '10:00 AM',
//       'completed': false
//     },
//     {
//       'title': 'Meeting with team',
//       'description': 'Discuss project updates',
//       'time': '2:00 PM',
//       'completed': false
//     },
//     // Add more TODOs here
//   ];

//   void _createTodo() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Create TODO'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(decoration: const InputDecoration(labelText: 'Title')),
//               TextField(
//                   decoration: const InputDecoration(labelText: 'Description')),
//               TextField(
//                   decoration: const InputDecoration(labelText: 'Time'),
//                   onTap: () async {
//                     TimeOfDay? picked = await showTimePicker(
//                         context: context, initialTime: TimeOfDay.now());
//                     if (picked != null) {
//                       // Handle time selection
//                     }
//                   }),
//             ],
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('Cancel')),
//             TextButton(
//                 onPressed: () {
//                   // Handle TODO creation
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Create')),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Tasks'),
//         backgroundColor: Colors.amber[100],
//       ),
//       body: ListView.builder(
//         itemCount: _todos.length,
//         itemBuilder: (context, index) {
//           final todo = _todos[index];
//           return ListTile(
//             title: Text(todo['title']),
//             subtitle: Text('${todo['description']} - ${todo['time']}'),
//             trailing: Checkbox(
//               value: todo['completed'],
//               onChanged: (bool? value) {
//                 setState(() {
//                   todo['completed'] = value!;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _createTodo,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import 'add_todo_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoProvider>(context).todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All TODOs'),
        backgroundColor: Colors.amber[100],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (ctx, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description ?? ''),
            trailing: IconButton(
              icon: Icon(
                todo.isCompleted
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
              onPressed: () {
                Provider.of<TodoProvider>(context, listen: false)
                    .toggleDone(todo);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCupertinoModalBottomSheet(
          expand: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) =>
              const SingleChildScrollView(child: AddTodoScreen()),
          enableDrag: false,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
