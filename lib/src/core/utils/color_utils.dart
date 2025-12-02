import 'package:flutter/material.dart';

Color getAvatarColor(String name) {
  final colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
    Colors.amber,
  ];
  
  if (name.isEmpty) return colors[0];
  
  final int hash = name.codeUnits.fold(0, (prev, element) => prev + element);
  return colors[hash % colors.length];
}
