import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mozz_chat_app/chats_screen.dart';
import 'package:mozz_chat_app/message_model.dart';
import 'package:mozz_chat_app/theme/theme.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  await Hive.openBox<Message>(
    'chats',
  ); // Общий бокс для хранения информации о чатах
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mozz Chat App',
      theme: theme,
      home: const ChatsScreen(),
    );
  }
}
