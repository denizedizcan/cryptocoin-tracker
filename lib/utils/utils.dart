import 'package:flutter/material.dart';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content.toUpperCase(),
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Theme.of(context).colorScheme.inverseSurface,
  ));
}
