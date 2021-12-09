import 'dart:convert';

class item {
  final int? id;
  final String name;
  bool? isCompleted;
  bool? isArchived;

  item(
      {this.id,
      required this.name,
      this.isArchived,
      this.isCompleted}); // { süslü parantez koyduk opsiyonel olması için.

  factory item.fromJson(Map<String, dynamic> map) {
    return item(
        id: map['id'],
        name: map['name'],
        isArchived: map['isArchived'],
        isCompleted: map['isCompleted']);
  }

  String toJson() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['isArchived'] = isArchived;
    map['isCompleted'] = isCompleted;
    return jsonEncode(map);
  }
}
