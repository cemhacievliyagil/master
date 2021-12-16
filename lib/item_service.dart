import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  Item({required this.item, this.id = ""});

  Item.fromJson(Map<String, Object?> json)
      : this(
          item: json['item']! as String,
        );

  final String item;
  final String id;

  Map<String, Object?> toJson() {
    return {
      'item': item,
    };
  }

  static final itemsRef = FirebaseFirestore.instance.collection('items');

  static Future<void> addItem(String item1) async {
    // Obtain science-fiction movies

    // Add a movie
    await itemsRef.add({'item': item1});
  }
}
