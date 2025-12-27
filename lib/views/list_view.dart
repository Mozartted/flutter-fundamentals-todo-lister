import 'package:flutter/material.dart';
import 'package:todo_lister/models.dart';

enum TodoState { done, pending }

class TodoListItem {
  final String name;
  TodoState state;

  TodoListItem({required this.name, required this.state});
}

typedef TodoList = List<TodoListItem>;

class TodoListViewer extends StatelessWidget {
  const TodoListViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final todoList = TodoListStore.of(context).todoList;

    return Container(
      child: ListenableBuilder(
        listenable: todoList,
        builder: (BuildContext ctx, child) {
          return ListView.builder(
            itemCount: todoList.todoList.length,
            itemBuilder: (BuildContext ctx, int i) {
              var todoItem = todoList.todoList[i];
              return ListTile(
                title: Text(todoItem.name, style: TextStyle(fontSize: 15)),
                trailing: IconButton(
                  onPressed: () => todoList.checked(i),
                  icon: todoItem.state == TodoState.done
                      ? Icon(Icons.check_circle)
                      : Icon(Icons.check_circle_outlined),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
