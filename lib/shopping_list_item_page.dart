import 'package:flutter/material.dart';
import 'item.dart';
import 'item_service.dart';

class ShoppingListItemPage extends StatefulWidget {
  const ShoppingListItemPage({Key? key}) : super(key: key);

  @override
  _ShoppingListItemPageState createState() => _ShoppingListItemPageState();
}

class _ShoppingListItemPageState extends State<ShoppingListItemPage> {
  @override
  itemservice? itemservice1;
  void initState() {
    itemservice1 = itemservice();
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemservice1?.fetchItems(),
      builder: (BuildContext context, AsyncSnapshot<List<item>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              item item1 = snapshot.data![index];
              return ListTile(title: Text(item1.name));
            },
          );
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
