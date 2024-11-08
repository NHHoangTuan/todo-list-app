import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import 'package:uuid/uuid.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  final ScrollController _descriptionScrollController = ScrollController();
  final ValueNotifier<bool> _isTitleNotEmpty = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      _isTitleNotEmpty.value = _titleController.text.isNotEmpty;
    });
  }

  void _submitData() {
    if (_titleController.text.isEmpty) {
      return;
    }
    final newTodo = Todo(
      id: const Uuid().v4(),
      title: _titleController.text,
      description: _descriptionController.text,
      deadline: _updateDeadline(),
      createdAt: DateTime.now(),
    );

    Provider.of<TodoProvider>(context, listen: false).add(newTodo);
    Navigator.of(context).pop();
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _pickedTime = pickedTime;
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  DateTime? _updateDeadline() {
    if (_pickedDate == null && _pickedTime == null) {
      return null;
    }
    DateTime finalDate = _pickedDate ??
        DateTime.now(); // Dùng ngày đã chọn hoặc mặc định là hôm nay
    int hour = _pickedTime?.hour ?? 23; // Lấy giờ đã chọn hoặc mặc định là 0
    int minute =
        _pickedTime?.minute ?? 59; // Lấy phút đã chọn hoặc mặc định là 0

    final DateTime deadline = DateTime(
      finalDate.year,
      finalDate.month,
      finalDate.day,
      hour,
      minute,
    );

    return deadline;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Scrollbar(
                  controller: _descriptionScrollController,
                  child: SingleChildScrollView(
                    controller: _descriptionScrollController,
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3, // Allow multiple lines
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                          ),
                        ),
                        readOnly: true,
                        onTap: _pickDate,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: _timeController,
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.schedule,
                          ),
                        ),
                        readOnly: true,
                        onTap: _pickTime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                ValueListenableBuilder<bool>(
                  valueListenable: _isTitleNotEmpty,
                  builder: (context, isTitleNotEmpty, child) {
                    return Ink(
                      decoration: ShapeDecoration(
                        color: isTitleNotEmpty
                            ? Colors.amber[200]
                            : Colors.grey[350],
                        shape: const CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.save),
                        color: Colors.black,
                        onPressed: isTitleNotEmpty ? _submitData : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
