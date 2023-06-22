import 'package:flutter/material.dart';

class Todo {
  String title;
  bool completed;

  Todo({
    required this.title,
    this.completed = false,
  });
}

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
        return Card(
          child: ListTile(
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
          ),
        );
      },
      itemCount: _todoList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF00B15C),
          centerTitle: true,
          title: Text(
            'Itens da lista',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  color: Color(0xfff2f1f2),
                  child: _buildTodoList(),
              ),
            ),
            Container(
              height: 70,
              color: Color(0xfff2f1f2),
              child:  Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric( vertical: 20.0),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(32))),
                              hintText: 'Digite algo...',

                              suffixIcon: Container(
                                height: 57,
                                width: 57,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  onPressed: () {
                                    // Função do botão
                                    String text = _textEditingController.text;
                                    // Faça algo com o texto digitado
                                    _addTodoItem(text);
                                  },
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00B15C),
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
