import 'package:flutter/material.dart';

import 'task.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<Task> _tasks = [];
  final _taskTitleController = TextEditingController();

  _addTask(String title) {
    setState(() {
      _tasks.add(Task(title: title));
    });
    _taskTitleController.clear();
  }

  _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index].toggleDone();
    });
  }

  Widget _buildTask(Task task, int index) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (_) => _toggleTaskStatus(index),
      ),
      onLongPress: () => _deleteTask(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) => _buildTask(_tasks[index], index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Add Task'),
            content: TextField(
              controller: _taskTitleController,
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_taskTitleController.text.isNotEmpty) {
                    _addTask(_taskTitleController.text);
                  }
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
