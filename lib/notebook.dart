import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'addnote.dart';
import 'editnote.dart';

class NotebookScreen extends StatelessWidget {
  @override
  final ref = FirebaseFirestore.instance.collection('notes');
  final Stream<QuerySnapshot> ref1 =
      FirebaseFirestore.instance.collection('notes').snapshots();
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Notes"),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addNote()));
              },
            ),
            body: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  var x;
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount:
                          snapshot.hasData ? snapshot.data?.docs.length : 0,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => editNote(
                                          editdoc: snapshot.data?.docs[index],
                                        )));
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              height: 10,
                              color: Colors.grey[200],
                              child: Column(
                                children: [
                                  Text((snapshot.data?.docs[index]
                                          .get('location'))
                                      .toString()),
                                  Text((snapshot.data?.docs[index].get('title'))
                                      .toString()),
                                  Text((snapshot.data?.docs[index]
                                          .get('content'))
                                      .toString()),
                                ],
                              )),
                        );
                      });
                })));
  }
}
