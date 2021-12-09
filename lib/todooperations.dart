import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/todoapi.dart';
import 'todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) => todoapi.createtodo(todo);

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void removeTodo(Todo todo) => todoapi.deleteTodo(todo);

  bool toggleStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    todoapi.updateTodo(todo);
    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    todoapi.updateTodo(todo);
  }
}
