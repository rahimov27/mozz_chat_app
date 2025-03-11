import 'package:flutter/material.dart';
import 'package:mozz_chat_app/app.dart';
import 'package:mozz_chat_app/theme.dart';

void main() {
  runApp(MaterialApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: App(), theme: theme);
  }
}
