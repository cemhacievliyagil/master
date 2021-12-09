import 'package:flutter/material.dart';
import 'package:flutter_application_1/todo.dart';
import 'package:flutter_application_1/todooperations.dart';
import 'todo_form_widget.dart';
import 'package:provider/provider.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  @override
  String title = '';
  String description = '';
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  final formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            IconButton(
                onPressed: () {
                  final provider =
                      Provider.of<TodoProvider>(context, listen: false);
                  provider.removeTodo(widget.todo);
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onchangedTitle: (title) => setState(() {
                this.title = title;
              }),
              onchangedDescription: (description) => setState(() {
                this.description = description;
              }),
              onsavedTodo: () => saveTodo(),
            ),
          ),
        ),
      );

  saveTodo() {
    final isvalid = formkey.currentState!.validate();
    if (!isvalid) {
      return;
    } else {
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description);
      Navigator.of(context).pop();
    }
  }
}
