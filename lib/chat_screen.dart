import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mozz_chat_app/message_model.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/chat_app_bar_widget.dart';
import 'package:mozz_chat_app/widgets/sended_message_widget.dart';

class ChatScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final Color color1;
  final Color color2;

  const ChatScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.color1,
    required this.color2,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Box<Message> chatBox;
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _imagePath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  String getChatId(String firstName, String lastName) {
    final fullName = '${firstName}_${lastName}_chat';
    final bytes = utf8.encode(fullName);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  void _openBox() async {
    final chatId = getChatId(widget.firstName, widget.lastName);
    chatBox = await Hive.openBox<Message>(chatId);
    setState(() {
      _isLoading = false;
    });
  }

  void saveMessage(String message, String? imagePath) {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    final newMessage = Message(
      text: message,
      timeStamp: DateFormat('HH:mm').format(DateTime.now()),
      imagePath: imagePath,
    );

    chatBox.put(key, newMessage);
    messageController.clear();
    setState(() {
      _imagePath = null;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Map<String, List<Message>> groupMessagesByDate(List<Message> messages) {
    final Map<String, List<Message>> groupedMessages = {};
    for (final message in messages) {
      // Получаем дату из времени сообщения
      final date = DateFormat('dd.MM.yy').format(DateTime.now());
      if (!groupedMessages.containsKey(date)) {
        groupedMessages[date] = [];
      }
      groupedMessages[date]!.add(message);
    }
    return groupedMessages;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final groupedMessages = groupMessagesByDate(chatBox.values.toList());

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: ChatAppBarWidget(
          firstName: widget.firstName,
          lastName: widget.lastName,
          color1: widget.color1,
          color2: widget.color2,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(color: AppColors.textFieldColor),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: chatBox.listenable(),
                builder: (context, Box<Message> box, _) {
                  final groupedMessages = groupMessagesByDate(
                    box.values.toList(),
                  );

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: groupedMessages.length,
                    itemBuilder: (context, index) {
                      final date = groupedMessages.keys.elementAt(index);
                      final messages = groupedMessages[date]!;

                      return Column(
                        children: [
                          // Отображаем дату только для первой группы сообщений
                          if (index == 0)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: AppColors.gray,
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                        fontFamily: "Gilroy",
                                        color: AppColors.gray,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: AppColors.gray,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 20),
                          // Отображаем сообщения
                          ...messages.map((message) {
                            final key = box.keys.firstWhere(
                              (k) => box.get(k) == message,
                            );
                            return SendedMessageWidget(
                              formattedTime: message.timeStamp,
                              message: message.text,
                              isImage: message.imagePath != null,
                              imagePath: message.imagePath,
                              messageKey: key,
                              onDelete: (key) {
                                box.delete(key);
                                setState(() {});
                              },
                            );
                          }).toList(),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Divider(color: AppColors.textFieldColor),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 23,
                left: 20,
                right: 20,
                top: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.textFieldColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: SvgPicture.asset("assets/svg/attach.svg"),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: TextField(
                        cursorColor: AppColors.gray,
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty || _imagePath != null) {
                            saveMessage(value, _imagePath);
                          }
                        },
                        controller: messageController,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 12),
                          hintText: "Сообщение",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w500,
                            color: AppColors.gray,
                          ),
                          fillColor: Color(0xffEDF2F6),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.textFieldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() async {
                            await Hive.deleteBoxFromDisk("messages");
                          });
                        },
                        child: SvgPicture.asset("assets/svg/audio.svg"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
