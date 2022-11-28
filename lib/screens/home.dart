import 'dart:html';

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widget/todo_item.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = [
    ToDo(id: '01', text: 'Create App', isDone: true),
    ToDo(id: '02', text: 'Vacuum the floors'),
    ToDo(id: '03', text: 'Wash the dishes'),
  ];
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: todoBackground,
      appBar: AppBar(
        title: Text('ToDo App'),
        backgroundColor: todoBlue,
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      child: Text('All Todos',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)),
                    ),
                    for (ToDo todoI in todoList)
                      TodoItem(
                        todo: todoI,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _handleToDoDeletion,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 15, right: 15, left: 15),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                      hintText: 'Add ToDo', border: InputBorder.none),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, right: 20),
              child: ElevatedButton(
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                onPressed: () {
                  _addToDoItem(_todoController.text);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(60, 60), elevation: 10),
              ),
            ),
          ]),
        )
      ]),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleToDoDeletion(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String todo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), text: todo));
    });
    _todoController.clear();
  }
}
