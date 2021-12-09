import 'package:flutter/material.dart';

class ItemDialog extends StatefulWidget {
  const ItemDialog({Key? key}) : super(key: key);

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final formkey = GlobalKey<FormState>();
  String? itemname;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Add your shopping item."),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: TextFormField(
                  maxLength: 50,
                  onSaved: (value) => itemname = value,
                  autofocus: true,
                  validator: (value) {
                    value?.isEmpty ?? "validation error";
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              FlatButton(
                child: Text("Add item to shopping list"),
                onPressed: () {
                  saveform();
                },
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        )
      ],
    );
  }

  saveform() {
    formkey.currentState?.save();

    Navigator.pop(context, itemname);
  }
}
