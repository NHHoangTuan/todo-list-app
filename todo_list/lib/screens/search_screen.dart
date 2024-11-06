// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo_model.dart';
import '../widgets/date_time_card.dart';
import 'todo_detail_bottom_sheet.dart';

class SearchTodoScreen extends StatefulWidget {
  const SearchTodoScreen({super.key});

  @override
  State<SearchTodoScreen> createState() => _SearchTodoScreenState();
}

class _SearchTodoScreenState extends State<SearchTodoScreen> {
  String searchQuery = '';

  final FocusNode _searchFocus = FocusNode(); // Add FocusNode

  @override
  void dispose() {
    _searchFocus.dispose(); // Clean up
    super.dispose();
  }

  List<Todo> _filterTodos(List<Todo> todos, String query) {
    if (query.isEmpty) return [];

    return todos.where((todo) {
      final titleMatch = todo.title.toLowerCase().contains(query.toLowerCase());
      final descMatch =
          todo.description?.toLowerCase().contains(query.toLowerCase()) ??
              false;
      return titleMatch || descMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final allTodos = Provider.of<TodoProvider>(context).todos;
    final filteredTodos = _filterTodos(allTodos, searchQuery);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.amber[100],
          title: const Text('Search'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                focusNode: _searchFocus,
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey[600]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey[600]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey[600]!),
                  ),
                  filled: false,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: searchQuery.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 80, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'Search for your tasks',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                  : filteredTodos.isEmpty
                      ? Center(
                          child: Text(
                            'No tasks found for "$searchQuery"',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredTodos.length,
                          itemBuilder: (context, index) {
                            final todo = filteredTodos[index];
                            return GestureDetector(
                              onTap: () => showTodoDetail(context, todo),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            todo.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (todo.description?.isNotEmpty ??
                                              false)
                                            Text(
                                              todo.description!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          if (todo.deadline != null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: DateTimeCard(
                                                  deadline: todo.deadline!),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            )
          ],
        ));
  }
}
