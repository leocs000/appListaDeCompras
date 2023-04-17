import 'package:flutter/material.dart';

class Todo {
  String title;
  bool completed;

  Todo({
    required this.title,
    this.completed = false,
  });
}

// class MyApp extends StatefulWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Lista()
//     );
//   }
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }

class Lista extends StatefulWidget {
  @override
  _ListaCompra createState() => _ListaCompra();
}
 
class _ListaCompra extends State<Lista> {
  final List<Todo> _todoList = [];

  final TextEditingController _textEditingController =
  TextEditingController();

  void _addTodoItem(String title) {
    setState(() {
      _todoList.add(Todo(title: title));
    });
    _textEditingController.clear();
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  void _toggleTodoItem(int index, bool? value) {
    setState(() {
      _todoList[index].completed = value ?? false;
    });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final todo = _todoList[index];
        return ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.completed ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: Checkbox(
            value: todo.completed,
            onChanged: (bool? value) {
              _toggleTodoItem(index, value);
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _removeTodoItem(index);
            },
          ),
        );
      },
      itemCount: _todoList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Add a new task',
              ),
              onSubmitted: (String value) {
                _addTodoItem(value);
              },
            ),
            Expanded(
              child: _buildTodoList(),
            ),
          ],
        ),
      ),
    );
  }
}
