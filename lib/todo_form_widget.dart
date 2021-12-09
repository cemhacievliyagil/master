import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  const TodoFormWidget(
      {Key? key,
      this.title = '',
      this.description = '',
      required this.onchangedDescription,
      required this.onchangedTitle,
      required this.onsavedTodo})
      : super(key: key);
  final String title;
  final String description;
  final ValueChanged<String> onchangedTitle;
  final ValueChanged<String> onchangedDescription;
  final VoidCallback onsavedTodo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(
            height: 6,
          ),
          buildDescription(),
          SizedBox(
            height: 10,
          ),
          buildButton()
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      onChanged: onchangedTitle,
      validator: (title) {
        if (title!.isEmpty) {
          return "Title can't be empty";
        }
        return null;
      },
      decoration:
          InputDecoration(border: UnderlineInputBorder(), labelText: 'Title'),
    );
  }

  Widget buildDescription() {
    return TextFormField(
      maxLines: 3,
      initialValue: description,
      onChanged: onchangedDescription,
      decoration: InputDecoration(
          border: UnderlineInputBorder(), labelText: 'Description'),
    );
  }

  Widget buildButton() {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: onsavedTodo,
            child: Text("Save")));
  }
}
