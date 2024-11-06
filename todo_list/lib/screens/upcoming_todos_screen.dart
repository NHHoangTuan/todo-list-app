import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import '../widgets/date_time_card.dart';
import '../widgets/tomorrow_card.dart';

class UpcomingTodoScreen extends StatelessWidget {
  const UpcomingTodoScreen({super.key});

  String formatDate(DateTime? date) {
    if (date == null) return 'No deadline';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String formatDescription(String? description) {
    if (description == null) return '';

    // Kiểm tra vị trí của ký tự xuống dòng
    int newlineIndex = description.indexOf('\n');

    // Nếu có \n, chỉ lấy phần trước \n và thêm dấu "..."
    if (newlineIndex != -1) {
      return description.substring(0, newlineIndex) + '...';
    }

    // Nếu không có \n, trả về văn bản đầy đủ
    return description;
  }

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoProvider>(context).upcomingTodos;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: const Text('Upcoming Tasks'),
      ),
      body: todos.isEmpty
          ? const Center(
              child: Text('Great, no work coming up, just relax.'),
            )
          : Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (ctx, index) {
                    final Todo todo = todos[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 8, 16),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 14,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    Text(
                                      todo.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Description
                                    Text(
                                      formatDescription(todo.description),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Deadline Tag

                                    // Hiển thị Tomorrow card nếu deadline là ngày mai, còn không thì hiển thị DateTimeCard, nếu không có dealine thì không hiển thị gì
                                    if (todo.deadline != null &&
                                        todo.deadline!
                                            .isAfter(DateTime.now()) &&
                                        todo.deadline!.isBefore(DateTime.now()
                                            .add(Duration(days: 2))))
                                      TomorrowCard(
                                        deadline: todo.deadline!,
                                      )
                                    else if (todo.deadline != null)
                                      DateTimeCard(
                                          deadline: todo
                                              .deadline!) // Hiện DateTimeCard nếu có deadline
                                    else
                                      SizedBox(), // Không hiển thị gì nếu deadline là null

                                    // todo.deadline != null
                                    //     ? DateTimeCard(
                                    //         deadline: todo
                                    //             .deadline!) // Hiện DateTimeCard nếu có deadline
                                    //     : SizedBox(), // Không hiển thị gì nếu deadline là null
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: IconButton(
                                  icon: Icon(
                                    todo.isCompleted
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: Colors.amber,
                                  ),
                                  onPressed: () async {
                                    // Tạo một bản sao của todo để thay đổi trạng thái tạm thời
                                    final tempTodo = todo.copyWith(
                                        isCompleted: !todo.isCompleted);

                                    // Cập nhật trạng thái tạm thời
                                    Provider.of<TodoProvider>(context,
                                            listen: false)
                                        .updateTodoTemp(tempTodo);

                                    //Chờ 1 giây rồi xóa TODO
                                    await Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      Provider.of<TodoProvider>(context,
                                              listen: false)
                                          .toggleDone(todo);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
