import 'dart:convert';
import 'dart:math';

import 'package:flutter_application_1/item.dart';
import 'package:http/http.dart' as http;

class itemservice {
  static final String serviceurl =
      'https://kesali-shopping.herokuapp.com/item/';

  Future<List<item>> fetchItems() async {
    final response = await http.get(serviceurl);

    if (response.statusCode == 200) {
      Iterable items = jsonDecode(response.body); //iterable objesine dönüşüyor
      return items
          .map((Item) => item.fromJson(Item))
          .toList(); //dart objesine dönüşüyor
    } else {
      throw Exception("Error!");
    }
  }

  static Future<item> addItem(String itemjson) async {
    final response = await http.post(serviceurl,
        headers: {'content-type': 'applicaton/json'}, body: itemjson);
    if (response.statusCode == 201) {
      Map<String, dynamic> item2 = jsonDecode(response.body);
      return item.fromJson(item2);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
