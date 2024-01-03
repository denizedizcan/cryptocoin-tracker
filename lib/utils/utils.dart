import 'package:flutter/material.dart';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    ),
    backgroundColor: Theme.of(context).colorScheme.onSecondary,
  ));
}
