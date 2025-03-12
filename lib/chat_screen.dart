import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/chat_app_bar_widget.dart';
import 'package:mozz_chat_app/widgets/recieve_message_widget.dart';
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
  // Controller of message
  final TextEditingController messageController = TextEditingController();

  // Messages list
  final List<Map<String, String>> messages = [];

  // Function to adding a message
  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({
        "time": DateFormat('HH:mm').format(DateTime.now()),
        "message": message,
      });
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(time);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
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
            Spacer(),
            // Sended message here
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, int index) {
                  final msg = messages[index];
                  return SendedMessageWidget(
                    formattedTime: msg['time']!,
                    message: msg['message']!,
                  );
                },
              ),
            ),
            Spacer(),
            RecieveMessageWidget(formattedTime: formattedTime),
            Spacer(),

            // Textfield part
            Padding(
              padding: const EdgeInsets.only(bottom: 23, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.textFieldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: SvgPicture.asset("assets/svg/attach.svg"),
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
                          _sendMessage(value);
                        },
                        controller: messageController,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                        decoration: InputDecoration(
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
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
                      child: SvgPicture.asset("assets/svg/audio.svg"),
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
