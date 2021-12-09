import 'package:flutter/material.dart';
import 'package:flutter_application_1/todoapi.dart';
import 'package:flutter_application_1/todooperations.dart';
import 'package:provider/provider.dart';
import 'add_todo_dialog_widget.dart';
import 'todo_list_widget.dart';
import 'completed_list_widget.dart';
import 'todo.dart';
import 'todoapi.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [TodoListWidget(), CompletedListWidget()];
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        backgroundColor: Colors.pink,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedindex,
        onTap: (index) => setState(() {
          selectedindex = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
                size: 28,
              ),
              label: 'Done')
        ],
      ),
      body: StreamBuilder<List<Todo>>(
          stream: todoapi.readTodos(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Text(
                      'Something Went Wrong' + snapshot.error.toString());
                } else {
                  var todos = snapshot.data ?? [];
                  final provider = Provider.of<TodoProvider>(context);
                  provider.setTodos(todos);
                  return tabs[selectedindex];
                }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AddTodoDialogWidget(),
            barrierDismissible: false),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Icon(Icons.add),
      ),
    );
  }
}
