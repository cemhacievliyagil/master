import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notebook.dart';
import 'package:firebase_core/firebase_core.dart';
import 'addnote.dart';
import 'shoppinglist.dart';
import 'todolist.dart';
import 'todooperations.dart';
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp1());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonSection = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          child: _buildButtonColumn(
            ('images/todolist.jpg'),
            'ToDo List',
          ),
          color: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ToDoListScreen()),
            );
          },
        ),
        MaterialButton(
          child: _buildButtonColumn(('images/notebook.jpg'), 'Notebook'),
          color: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotebookScreen()),
            );
          },
        ),
        MaterialButton(
          child:
              _buildButtonColumn(('images/shoppinglist.jpg'), 'Shopping List'),
          color: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingListScreen()),
            );
          },
        ),
        MaterialButton(
          child: _buildButtonColumn(('images/drawingpad.jpg'), 'Drawing Pad'),
          color: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotebookScreen()),
            );
          },
        ),
      ],
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Agenda'),
          backgroundColor: Color(0xFF151026),
        ),
        body: ListView(
          children: [
            buttonSection,
          ],
          padding: EdgeInsets.only(top: 100),
        ),
      ),
    );
  }

  Row _buildButtonColumn(String str, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          str,
          width: 100,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoProvider>(
        create: (context) => TodoProvider(),
        child: MaterialApp(
          routes: {
            '/': (context) => HomeScreen(),
            '/notebook': (context) => NotebookScreen(),
            '/shoppinglist': (context) => ShoppingListScreen(),
            '/todolist': (context) => ToDoListScreen()
          },
        ));
  }
}
