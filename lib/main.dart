import 'package:flutter/material.dart';
import 'package:mozz_chat_app/chats_screen.dart';
import 'package:mozz_chat_app/theme/theme.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChatsScreen(), theme: theme);
  }
}
