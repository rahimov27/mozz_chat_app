import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mozz_chat_app/bloc/send_message_bloc/send_bloc.dart';
import 'package:mozz_chat_app/chats_screen.dart';
import 'package:mozz_chat_app/message_model.dart';
import 'package:mozz_chat_app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Регистрируем адаптер перед открытием коробки
  Hive.registerAdapter(MessageAdapter());

  // Открываем коробку
  await Hive.openBox<Message>('messages');

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
