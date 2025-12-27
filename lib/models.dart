import 'package:flutter/material.dart';
import 'package:todo_lister/store/todo-view-model.dart';
import 'package:todo_lister/views/list_view.dart';

class TodoListStore extends InheritedWidget {
  // final List<TodoListItem>? todoList;

  final TodoViewModel todoList;
  const TodoListStore({
    super.key,
    required this.todoList,
    required super.child,
  });

  static TodoListStore of(BuildContext ctx) {
    final instancee = ctx.dependOnInheritedWidgetOfExactType<TodoListStore>();
    if (instancee == null) {
      throw Exception("Instance was null");
    }

    return instancee;
  }

  @override
  bool updateShouldNotify(TodoListStore oldWidget) {
    return oldWidget.todoList != todoList;
  }
}

class TodoListProvider<T extends Listenable> extends InheritedNotifier {
  const TodoListProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static T of<T extends Listenable>(BuildContext ctx) {
    final provider = ctx.dependOnInheritedWidgetOfExactType<TodoListProvider>();

    if (provider == null) {
      throw Exception("No todoListProvider found in context");
    }

    final notifier = provider.notifier;

    if (notifier == null) {
      throw Exception("no notifier found in todolist provider");
    }

    return notifier as T;
  }
}
