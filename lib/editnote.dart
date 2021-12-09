import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'addnote.dart';

class editNote extends StatefulWidget {
  editNote({required this.editdoc});

  QueryDocumentSnapshot? editdoc;

  @override
  _editNoteState createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  @override
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  String locationx = ' ';
  void initState() {
    title = TextEditingController(text: widget.editdoc?.get('title'));
    content = TextEditingController(text: widget.editdoc?.get('content'));
    locationx = (widget.editdoc?.get('location')).toString();
    super.initState();
  }

  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection('notes');

    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                widget.editdoc?.reference.update({
                  'title': title.text,
                  'content': content.text,
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text('Save')),
          FlatButton(
              onPressed: () {
                widget.editdoc?.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              child: Text('Delete')),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(locationx),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'Content'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
