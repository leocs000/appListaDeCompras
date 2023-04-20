/*import 'package:flutter/material.dart';


import 'criarLista.dart';

void main() {
  runApp(MyApp());
}

class TodoItem {
  String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoItem> _todoList = [];

  TextEditingController _textFieldController = TextEditingController();

  void _addTodoItem(String title) {
    setState(() {
      _todoList.add(TodoItem(title: title));
    });
    _textFieldController.clear();
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoList[index].isDone = !_todoList[index].isDone;
    });
  }

  void navigateToNewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Lista()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: 'Enter a new todo item',
              ),
              onSubmitted: (value) {
                _addTodoItem(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: navigateToNewPage,
                  child: Card(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _todoList[index].title,
                            style: TextStyle(
                              decoration: _todoList[index].isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          Checkbox(
                            value: _todoList[index].isDone,
                            onChanged: (bool? value) {
                              _toggleTodoItem(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:listadecompras/criarLista.dart';

class TodoItem {
  String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});
}

class TodoList extends StatefulWidget {
  @override
  _TextFieldWithButton createState() => _TextFieldWithButton();
}


class _TextFieldWithButton extends State<TodoList> {

  List<TodoItem> _todoList = [];

  TextEditingController _textFieldController = TextEditingController();

  void _addTodoItem(String title) {
    setState(() {
      _todoList.add(TodoItem(title: title));
    });
    _textFieldController.clear();
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoList[index].isDone = !_todoList[index].isDone;
    });
  }

  void navigateToNewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Lista()),
    );
  }

  @override
  Widget build(BuildContext context) {
    int i=0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Listas'),
      ),
      body: Column(

        children: [
          Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(

                    onTap: navigateToNewPage,
                    child: Card(
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _todoList[index].title,
                              style: TextStyle(
                                decoration: _todoList[index].isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            SizedBox(height: 50,)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            color: Color(0xfffafafa),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: TextField(
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        hintText: 'Digite algo...',
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Função do botão
                    String text = _textFieldController.text;
                    // Faça algo com o texto digitado
                    _addTodoItem(text);
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TodoList(),
  ));
}

