/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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
  List<String> _suggestions = [];
  String _selectedSuggestion = '';

  @override
  void initState() {
    super.initState();
    _fetchData().then((suggestions) {
      setState(() {
        _suggestions = suggestions;
      });
    });
  }

  Future<List<String>> _fetchData() async {
    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/leocs000/JsonItensMercado/main/NomeItensMercado.json'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<String> suggestions = List<String>.from(jsonData);

      return suggestions;
    } else {
      throw Exception('Falha ao carregar os dados da API');
    }
  }

  void _onTextChanged(String value) {
    setState(() {
      _selectedSuggestion = value;
    });
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _selectedSuggestion = suggestion;
      _textEditingController.text = suggestion;
    });
  }

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
                color: Color(0xFFF2F1F2),
                child: _buildTodoList(),
              ),
            ),
            Container(
              height: 70,
              color: Colors.white,//Color(0xFFF2F1F2),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
                            ),
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
                                  String text = _textEditingController.text;
                                  _addTodoItem(text);
                                },
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF00B15C),
                              ),
                            ),
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

}*/


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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

Future<List<String>> _fetchSuggestions(String pattern) async {
  final response = await http.get(Uri.parse('https://raw.githubusercontent.com/leocs000/JsonItensMercado/main/NomeItensMercado.json'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    final List<String> productList = jsonList.map((item) => item.toString()).toList();

    // Filtrar as sugestões com base no padrão de entrada
    final List<String> filteredList = productList
        .where((item) => item.toLowerCase().startsWith(pattern.toLowerCase()))
        .toList();

    return filteredList;
  } else {
    throw Exception('Falha ao carregar os dados do arquivo JSON');
  }
}


class _ListaCompra extends State<Lista> {
  final List<Todo> _todoList = [];
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                color: Color(0xFFF2F1F2),
                child: _buildTodoList(),
              ),
            ),
            Container(
              height: 70,
              color: Colors.white,//Color(0xFFF2F1F2),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: TypeAheadFormField<String>(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(32)),
                                ),
                                hintText: 'Digite algo...',
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              List<String> suggestions = await _fetchSuggestions(pattern);

                              // Filtrar as sugestões com base no padrão de entrada
                              List<String> filteredSuggestions = suggestions
                                  .where((item) => item.toLowerCase().startsWith(pattern.toLowerCase()))
                                  .toList();

                              return filteredSuggestions;
                            },
                            direction: AxisDirection.up,
                            itemBuilder: (BuildContext context, dynamic suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              _textEditingController.text = suggestion;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 57,
                      width: 57,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Função do botão
                            String text = _textEditingController.text;
                            // Faça algo com o texto digitado
                            _addTodoItem(text);
                          }
                        },
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00B15C),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
