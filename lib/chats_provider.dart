import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mozz_chat_app/message_model.dart';
import 'package:mozz_chat_app/widgets/app_chat_widget_row.dart';

class ChatsProvider extends ChangeNotifier {
  // searchController and focusNode for managing search state
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // late variable of Hive
  late Box<Message> chatsBox;

  // empty list of our messages
  List<Message> messages = [];

  // empty list of our filteredChats
  List<AppChatWidgetRow> filteredChats = [];

  // static chats for easily controlling and testing the chats
  final List<AppChatWidgetRow> chats = [
    AppChatWidgetRow(
      firstName: "Виктор",
      lastName: "Власов",
      date: "Вчера",
      color1: Colors.green,
      color2: Colors.green,
      message: "Empty",
    ),
    AppChatWidgetRow(
      firstName: "Саша",
      lastName: "Алексеев",
      date: "12.01.22",
      color1: Colors.red,
      color2: Colors.red,
      message: "Empty",
    ),
    AppChatWidgetRow(
      firstName: "Пётр",
      lastName: "Жаринов",
      date: "2 минуты назад",
      color1: Colors.green,
      color2: Colors.green,
      message: "Empty",
    ),
    AppChatWidgetRow(
      firstName: "Алина",
      lastName: "Жукова",
      date: "09:23",
      color1: Colors.red,
      color2: Colors.red,
      message: "Empty",
    ),
  ];

  // constructor
  ChatsProvider() {
    _initialize();
  }

  // Initialize the chats and open Hive box
  void _initialize() async {
    searchController.addListener(_filterChats);
    await _openBox();
    filteredChats = chats;
    notifyListeners();
  }

  // function which open out messages box which called chats
  Future<void> _openBox() async {
    chatsBox = await Hive.openBox<Message>('chats');
  }

  // method to filter our chats
  void _filterChats() {
    final query = searchController.text.toLowerCase();
    filteredChats = chats.where((chat) {
      return chat.firstName.toLowerCase().contains(query) ||
          chat.lastName.toLowerCase().contains(query);
    }).toList();
    notifyListeners();
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
  Future<void> deleteChat(int index) async {
    final chat = filteredChats[index];
    final chatId = getChatId(chat.firstName, chat.lastName);

    // deleted our box from Hive
    await Hive.deleteBoxFromDisk(chatId);

    // delete our chat from list
    filteredChats.removeAt(index);
    notifyListeners();
  }

  // clear our controllers
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

void initialize() async {
  await _openBox();

  // Получаем последний message для каждого чата
  final chatMessages = await Future.wait(
    chats.map((chat) async {
      final chatId = getChatId(chat.firstName, chat.lastName);
      final lastMessage = await getLastMessage(chatId);
      return {
        'chat': chat,
        'time': lastMessage?.timeStamp ?? '00:00', // Обрабатываем null значение
      };
    }).toList(),
  );

  // Сортируем чаты по времени последнего сообщения
  chatMessages.sort((a, b) {
    final timeA = a['time'] as String? ?? '00:00';
    final timeB = b['time'] as String? ?? '00:00';

    return timeB.compareTo(timeA);  // Сортируем по убыванию времени
  });

  // Применяем отсортированные чаты, преобразуя их обратно в список чатов
  filteredChats = chatMessages.map((item) => item['chat'] as AppChatWidgetRow).toList();

  notifyListeners();  // Обновляем UI после сортировки
}


}
