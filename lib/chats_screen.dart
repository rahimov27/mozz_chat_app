import 'dart:convert';
// ignore: depend_on_referenced_packages
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
  // searchController
  final TextEditingController _searchController = TextEditingController();

  // focusNode for hiding textField
  final FocusNode _searchFocusNode = FocusNode();

  // late variable of Hive
  late Box<Message> chatsBox;

  // empty list of our messages
  List<Message> messages = [];

  // empty list of our filteredChats
  List<AppChatWidgetRow> filteredChats = [];

  // static chats for easily controlling and test the chats
  final List<AppChatWidgetRow> chats = [
    AppChatWidgetRow(
      firstName: "Виктор",
      lastName: "Власов",
      date: "Вчера",
      color1: AppColors.green1,
      color2: AppColors.green2,
      message: "Empty",
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

  // init state method
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterChats);
    _openBox();
    filteredChats = chats;
  }

  // function which open out messages box which called chats
  void _openBox() async {
    chatsBox = await Hive.openBox<Message>('chats');
  }

  // method to filter our chats
  void _filterChats() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredChats =
          chats.where((chat) {
            return chat.firstName.toLowerCase().contains(query) ||
                chat.lastName.toLowerCase().contains(query);
          }).toList();
    });
  }

  // mehtod for getting our chatID
  String getChatId(String firstName, String lastName) {
    final fullName = '${firstName}_${lastName}_chat';
    final bytes = utf8.encode(fullName);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // method for getting last message
  Future<Message?> getLastMessage(String chatId) async {
    try {
      if (!Hive.isBoxOpen(chatId)) {
        await Hive.openBox<Message>(chatId);
      }
      final chatBox = Hive.box<Message>(chatId);
      return chatBox.isNotEmpty ? chatBox.values.last : null;
    } catch (e) {
      return null;
    }
  }

  // method which delete message
  void _deleteChat(int index) async {
    final chat = filteredChats[index];
    final chatId = getChatId(chat.firstName, chat.lastName);

    // deleted our box from Hive
    await Hive.deleteBoxFromDisk(chatId);

    // delete our chat from list
    setState(() {
      filteredChats.removeAt(index);
    });

    // show our Snackbar when we delete the chat
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Чат с ${chat.firstName} ${chat.lastName} удален"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // clear our controllers
  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitleWidget(),
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppSearchFieldWidget(
              controller: _searchController,
              focusNode: _searchFocusNode,
            ),
            SizedBox(height: 24),
            Divider(color: AppColors.textFieldColor),
            Expanded(
              child: ListView.builder(
                itemCount: filteredChats.length,
                itemBuilder: (BuildContext context, int index) {
                  final chat = filteredChats[index];
                  final chatId = getChatId(chat.firstName, chat.lastName);
                  return Dismissible(
                    key: Key(chatId),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _deleteChat(index);
                    },
                    child: FutureBuilder<Message?>(
                      future: getLastMessage(chatId),
                      builder: (context, snapshot) {
                        final lastMessage = snapshot.data;
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ChatScreen(
                                      firstName: chat.firstName,
                                      lastName: chat.lastName,
                                      color1: chat.color1,
                                      color2: chat.color2,
                                      onReturn: () {},
                                    ),
                              ),
                            );
                            setState(() {});
                          },
                          child: AppChatWidgetRow(
                            message: lastMessage?.text ?? "Нет сообщений",
                            firstName: chat.firstName,
                            lastName: chat.lastName,
                            date: lastMessage?.timeStamp ?? chat.date,
                            color1: chat.color1,
                            color2: chat.color2,
                          ),
                        );
                      },
                    ),
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
