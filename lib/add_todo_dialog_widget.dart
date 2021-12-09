import 'package:flutter/material.dart';
import 'package:flutter_application_1/todo.dart';
import 'package:flutter_application_1/todo_list_widget.dart';
import 'package:flutter_application_1/todooperations.dart';
import 'package:provider/provider.dart';
import 'todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({Key? key}) : super(key: key);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final formkey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Todo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 8,
            ),
            TodoFormWidget(
              onchangedTitle: (title) => setState(() {
                this.title = title;
              }),
              onchangedDescription: (description) => setState(() {
                this.description = description;
              }),
              onsavedTodo: addTodo,
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final isvalid = formkey.currentState!.validate();
    if (!isvalid) {
      return;
    } else {
      final todo = Todo(
          id: DateTime.now().toString(),
          createdTime: DateTime.now(),
          description: description,
          title: title);
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }
}
