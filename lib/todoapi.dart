import 'package:cloud_firestore/cloud_firestore.dart';
import 'utils.dart';
import 'todo.dart';
import 'dart:async';

class todoapi {
  static Future<String> createtodo(Todo todo) async {
    final doctodo = FirebaseFirestore.instance.collection('todo').doc();
    todo.id = doctodo.id;
    await doctodo.set(todo.toJson());
    return doctodo.id;
  }

  static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson) as StreamTransformer<
          QuerySnapshot<Map<String, dynamic>>, List<Todo>>);

  static Future updateTodo(Todo todo) async {
    final doctodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await doctodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final doctodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await doctodo.delete();
  }
}
