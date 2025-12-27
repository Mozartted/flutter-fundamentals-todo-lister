import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_lister/models.dart';
import 'package:todo_lister/store/todo-view-model.dart';

typedef ValueChanged<T> = void Function(T);

class EntryForm extends StatefulWidget {
  // final ValueChanged<String> onChanged;
  final BuildContext outerContext;
  const EntryForm({super.key, required this.outerContext});
  // const EntryForm({super.key, required this.onChanged});

  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  String? inputEntry;

  final TextEditingController _entryInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoModel = TodoListProvider.of<TodoViewModel>(widget.outerContext);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add new Task",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _entryInputController,
                    decoration: InputDecoration(
                      fillColor: Colors.blueGrey,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 0,
                        ),
                      ),
                      labelText: "Title",
                      labelStyle: TextStyle(fontWeight: FontWeight.w300),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 0.5,
                        ),
                      ),
                    ),

                    onChanged: (input) {
                      setState(() {
                        inputEntry = input;
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: () {
                        // widget.onChanged(inputEntry!);
                        todoModel.addTodo(inputEntry!);
                        _entryInputController.text = "";
                      },
                      child: Icon(Icons.add),
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
