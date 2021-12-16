import 'package:flutter/material.dart';
import 'item.dart';
import 'item_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingListItemPage extends StatefulWidget {
  const ShoppingListItemPage({Key? key}) : super(key: key);

  @override
  _ShoppingListItemPageState createState() => _ShoppingListItemPageState();
}

class _ShoppingListItemPageState extends State<ShoppingListItemPage> {
  @override
  Item? itemservice1;
  void initState() {
    itemservice1 = Item(item: "");
    super.initState();
  }

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('items');
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firestore.get(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: (snapshot.data! as QuerySnapshot).docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot ds =
                  (snapshot.data! as QuerySnapshot).docs[index];
              return ListTile(
                  title: Container(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              "${(snapshot.data! as QuerySnapshot).docs[index]['item']}"),
                          FlatButton(
                              onPressed: () {
                                firestore.doc(ds.id).delete();
                                setState(() {});
                              },
                              child: Icon(Icons.delete)),
                        ],
                      )));
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
