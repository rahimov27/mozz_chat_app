import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozz_chat_app/bloc/send_message_bloc/send_bloc.dart';
import 'package:mozz_chat_app/chats_screen.dart';
import 'package:mozz_chat_app/theme/theme.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendBloc(),
      child: MaterialApp(home: ChatsScreen(), theme: theme),
    );
  }
}
