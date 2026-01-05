import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:todo_lister/views/list_view.dart';
import 'package:http/http.dart' as http;

class TodoViewModel extends ChangeNotifier {
  TodoList todoList = [];

  final SecurityContext securityContext = SecurityContext(
    withTrustedRoots: false,
  );

  var host = "http://localhost:8082/todo";

  Future<void> initTodoList() async {
    await Future.delayed(Duration(seconds: 2));

    var res = await http.get(Uri.parse(host));

    dynamic resp = jsonDecode(res.body) as Map<String, dynamic>;

    print("Called here");
    List<Map<String, dynamic>> records = (resp['todo'] as List<dynamic>)
        .map((i) => i as Map<String, dynamic>)
        .toList();
    print(records);

    // load up the todolist here
    todoList = records.map((i) {
      return TodoListItem(
        name: i['id'] as String,
        state: (i['status'] as String) == "PENDING"
            ? TodoState.pending
            : TodoState.done,
      );
    }).toList();
    notifyListeners();
  }

  void addTodo(String name) {
    todoList.add(TodoListItem(name: name, state: TodoState.pending));
    notifyListeners();
  }

  void checked(int index) {
    if (todoList[index].state == TodoState.done) {
      todoList[index].state = TodoState.pending;
    } else {
      todoList[index].state = TodoState.done;
    }
    notifyListeners();
  }
}
