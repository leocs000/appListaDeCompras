import 'package:flutter/material.dart';

import 'main.dart';

class AddItemInputButton extends StatelessWidget{
  TextEditingController _textFieldController = TextEditingController();
  late TextFieldWithButton batata;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Color(0xfff2f1f2),
      child:  Row(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  controller: _textFieldController,
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
                            String text = _textFieldController.text;
                            // Faça algo com o texto digitado
                            batata = new TextFieldWithButton();
                           // batata.addTodoItem(text);
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
    );
  }
}