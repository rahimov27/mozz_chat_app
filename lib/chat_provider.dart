import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozz_chat_app/message_model.dart';

class ChatProvider with ChangeNotifier {
  late Box<Message> chatBox;
  bool _isLoading = true;
  String? _imagePath;
  final TextEditingController messageController = TextEditingController();

  bool get isLoading => _isLoading;
  String? get imagePath => _imagePath;

  // Initialize chat box
  void initBox(String firstName, String lastName) async {
    final chatId = getChatId(firstName, lastName);
    chatBox = await Hive.openBox<Message>(chatId);
    _isLoading = false;
    notifyListeners();
  }

  // Get chat ID using SHA256
  String getChatId(String firstName, String lastName) {
    final fullName = '${firstName}_${lastName}_chat';
    final bytes = utf8.encode(fullName);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // Save message to the chat box
  Future<void> saveMessage(String message, String? imagePath) async {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    final newMessage = Message(
      text: message,
      timeStamp: DateFormat('HH:mm').format(DateTime.now()),
      imagePath: imagePath,
    );
    await chatBox.put(key, newMessage);
    await chatBox.flush();
    messageController.clear();
    _imagePath = null;
    notifyListeners();
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imagePath = pickedFile.path;
      notifyListeners();  // Notify listeners to update UI
    }
  }

  // Delete all messages
  Future<void> clearMessages() async {
    await Hive.deleteBoxFromDisk("messages");
    notifyListeners();
  }

  // Group messages by date
  Map<String, List<Message>> groupMessagesByDate(List<Message> messages) {
    final Map<String, List<Message>> groupedMessages = {};
    final now = DateTime.now();
    final today = DateFormat('dd.MM.yy').format(now);

    for (final message in messages) {
      final messageDate = DateFormat('dd.MM.yy').format(DateTime.now());
      final displayDate = (messageDate == today) ? "Сегодня" : messageDate;

      if (!groupedMessages.containsKey(displayDate)) {
        groupedMessages[displayDate] = [];
      }
      groupedMessages[displayDate]!.add(message);
    }
    return groupedMessages;
  }
}
