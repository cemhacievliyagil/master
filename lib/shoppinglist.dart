import 'package:flutter/material.dart';
import 'shoppinglistpage.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lime, backgroundColor: Colors.redAccent),
      home: ShoppingListPage(),
    );
  }
}
