import 'package:flutter/material.dart';
import 'package:flutter_application_1/item.dart';
import 'package:flutter_application_1/item_dialog.dart';
import 'package:flutter_application_1/item_service.dart';
import 'package:flutter_application_1/shopping_list_item_page.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  ShoppingListPage_State createState() => ShoppingListPage_State();
}

class ShoppingListPage_State extends State<ShoppingListPage> {
  static Future<List<item>>? _future;
  int _selectedindex = 0;
  final PageController pageController = PageController();
  itemservice? itemservice1;
  final scaffoldstate = GlobalKey<ScaffoldState>();
  void initState() {
    itemservice1 = itemservice();
    pageController.addListener(() {
      int currentIndex = pageController.page!.round();
      if (currentIndex != _selectedindex) {
        _selectedindex = currentIndex;

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldstate,
      appBar: AppBar(
        title: Text("Shopping List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String itemname = await showDialog(
              context: context,
              builder: (BuildContext context) => ItemDialog());
          if (itemname.isNotEmpty) {
            var item1 = item(name: itemname);

            try {
              await itemservice?.addItem(item1.toJson());
              setState(() {});
            } catch (e) {
              scaffoldstate.currentState!
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Shopping List',
          ),
        ],
        currentIndex: _selectedindex,
        onTap: tikla,
        selectedItemColor: Colors.blue,
      ),
      body: PageView(controller: pageController, children: <Widget>[
        Container(color: Colors.orange),
        ShoppingListItemPage(),
      ]),
    );
  }

  tikla(int deger) {
    setState(() {
      _selectedindex = deger;
    });
    if (pageController.hasClients) {
      pageController.animateToPage(
        deger,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 400),
      );
    }
  }
}
