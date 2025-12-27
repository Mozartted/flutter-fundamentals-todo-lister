import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_lister/common.dart';
import 'package:todo_lister/models.dart';
import 'package:todo_lister/store/todo-view-model.dart';
import 'package:todo_lister/views/list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoLister',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // TRY THIS: Try running your application with "flutter run". You'll see
      //   // the application has a purple toolbar. Then, without quitting the app,
      //   // try changing the seedColor in the colorScheme below to Colors.green
      //   // and then invoke "hot reload" (save your changes or press the "hot
      //   // reload" button in a Flutter-supported IDE, or press "r" if you used
      //   // the command line to start the app).
      //   //
      //   // Notice that the counter didn't reset back to zero; the application
      //   // state is not lost during the reload. To reset the state, use hot
      //   // restart instead.
      //   //
      //   // This works for code too, not just values: Most code changes can be
      //   // tested with just a hot reload.
      //   colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: const TodoHome(title: 'TodoLister'),
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TodoHome> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TodoHome> {
  // final List<TodoListItem> listRef = [
  //   (name: "Base Refactoring", state: TodoState.pending),
  //   (name: "Review internal docs", state: TodoState.done),
  //   (name: "Migrate stuff to AWS", state: TodoState.pending),
  //   (name: "Update on the statement", state: TodoState.pending),
  // ];

  final TodoViewModel viewModel = TodoViewModel();

  void enterTodo(String value) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // listRef.add((name: value, state: TodoState.pending));
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the enterTodo method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return TodoListProvider(
      notifier: TodoViewModel(),
      child: Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.title),
          ),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [Expanded(child: TodoListViewer())]),
          ),
        ),
        floatingActionButton: Builder(
          builder: (BuildContext ctx1) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: ctx1,
                  isScrollControlled: true,
                  builder: (BuildContext ctx) {
                    return EntryForm(
                      outerContext: ctx1,
                      // onChanged: (String value) {
                      //   enterTodo(value);
                      // },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
