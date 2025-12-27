import 'package:flutter/widgets.dart';
import 'package:todo_lister/views/list_view.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoList todoList = [];

  Future<void> initTodoList() async {
    await Future.delayed(Duration(seconds: 2));
    todoList.addAll([
      TodoListItem(name: "Base Refactoring", state: TodoState.pending),
      TodoListItem(name: "Review internal docs", state: TodoState.done),
      TodoListItem(name: "Migrate stuff to AWS", state: TodoState.pending),
      TodoListItem(name: "Update on the statement", state: TodoState.pending),
    ]);
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
