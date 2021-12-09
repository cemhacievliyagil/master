import 'package:flutter/material.dart';
import 'package:flutter_application_1/todo.dart';
import 'package:flutter_application_1/todooperations.dart';
import 'todo_widget.dart';
import 'package:provider/provider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todos;
    return todos.isEmpty
        ? Center(
            child: Text(
              'No Todos',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final todo = todos[index];
              if (todo.isDone != true) {
                return TodoWidget(todo: todo);
              } else {
                return Text("");
              }
            },
            itemCount: todos.length);
  }
}
