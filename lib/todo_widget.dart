import 'package:flutter/material.dart';
import 'package:flutter_application_1/todooperations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'todo.dart';
import 'package:provider/provider.dart';
import 'utils.dart';
import 'todooperations.dart';
import 'edit_todo_page.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key? key, required this.todo}) : super(key: key);
  final Todo todo;
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          child: buildTodo(context),
          actionPane: SlidableDrawerActionPane(),
          key: Key(todo.id),
          actions: [
            IconSlideAction(
              icon: Icons.edit,
              color: Colors.green,
              caption: "Edit",
              onTap: () => editTodo(context, todo),
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              icon: Icons.delete,
              onTap: () => deleteTodo(context, todo),
            )
          ],
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Material(
                  child: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) {
                      final provider =
                          Provider.of<TodoProvider>(context, listen: false);
                      final isDone = provider.toggleStatus(todo);
                      Utils.showSnackBar(
                          context, isDone ? "Done" : "Marked as incomplete");
                    },
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                          fontSize: 20),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ))
              ],
            )),
      );

  deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    provider.removeTodo(todo);
    Utils.showSnackBar(context, 'Deleted');
  }

  editTodo(BuildContext context, Todo todo) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo)));
}
