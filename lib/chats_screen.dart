import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mozz_chat_app/chat_screen.dart';
import 'package:mozz_chat_app/message_model.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/app_bar_title_widget.dart';
import 'package:mozz_chat_app/widgets/app_chat_widget_row.dart';
import 'package:mozz_chat_app/widgets/app_search_field_widget.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Box<Message> chatsBox;
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  void _openBox() async {
    chatsBox = await Hive.openBox<Message>('chats');
  }

  // Функция для получения последнего сообщения из бокса чата
  Future<Message?> getLastMessage(String chatId) async {
    try {
      if (!Hive.isBoxOpen(chatId)) {
        await Hive.openBox<Message>(
          chatId,
        ); // Открываем бокс, если он еще не открыт
      }
      final chatBox = Hive.box<Message>(chatId);
      if (chatBox.isNotEmpty) {
        return chatBox.values.last; // Возвращаем последнее сообщение
      }
      return null; // Если сообщений нет
    } catch (e) {
      print("Ошибка при открытии бокса: $e");
      return null;
    }
  }

  // Функция для создания уникального идентификатора чата
  String getChatId(String firstName, String lastName) {
    final fullName = '${firstName}_${lastName}_chat';
    final bytes = utf8.encode(fullName);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  final List<AppChatWidgetRow> chats = [
    AppChatWidgetRow(
      firstName: "Виктор",
      lastName: "Власов",
      date: "Вчера",
      color1: AppColors.green1,
      color2: AppColors.green2,
      message: "Empty", // Это значение будет заменено на последнее сообщение
    ),
    AppChatWidgetRow(
      firstName: "Саша",
      lastName: "Алексеев",
      date: "12.01.22",
      color1: AppColors.red1,
      color2: AppColors.red2,
      message: "Empty",
    ),
    AppChatWidgetRow(
      firstName: "Пётр",
      lastName: "Жаринов",
      date: "2 минуты назад",
      color1: AppColors.green1,
      color2: AppColors.green2,
      message: "Empty",
    ),
    AppChatWidgetRow(
      firstName: "Алина",
      lastName: "Жукова",
      date: "09:23",
      color1: AppColors.red1,
      color2: AppColors.red2,
      message: "Empty",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarTitleWidget(), centerTitle: false),
      body: SafeArea(
        child: Column(
          children: [
            AppSearchFieldWidget(controller: _searchController),
            SizedBox(height: 24),
            Divider(color: AppColors.textFieldColor),
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  final chat = chats[index];
                  final chatId = getChatId(chat.firstName, chat.lastName);

                  return FutureBuilder<Message?>(
                    future: getLastMessage(chatId),
                    builder: (context, snapshot) {
                      final lastMessage = snapshot.data;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ChatScreen(
                                    firstName: chat.firstName,
                                    lastName: chat.lastName,
                                    color1: chat.color1,
                                    color2: chat.color2,
                                  ),
                            ),
                          );
                        },
                        child: AppChatWidgetRow(
                          message:
                              lastMessage?.text ??
                              "Нет сообщений", // Используем последнее сообщение
                          firstName: chat.firstName,
                          lastName: chat.lastName,
                          date:
                              lastMessage?.timeStamp ??
                              chat.date, // Используем дату последнего сообщения
                          color1: chat.color1,
                          color2: chat.color2,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
