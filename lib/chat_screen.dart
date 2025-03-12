import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/chat_app_bar_widget.dart';
import 'package:mozz_chat_app/widgets/recieve_message_widget.dart';
import 'package:mozz_chat_app/widgets/send_messag_widget_buttons.dart';
import 'package:mozz_chat_app/widgets/sended_message_widget.dart';

class ChatScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    final time = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(time);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: ChatAppBarWidget(
          firstName: firstName,
          lastName: lastName,
          color1: color1,
          color2: color2,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(color: AppColors.textFieldColor),
            Spacer(),
            SendedMessageWidget(formattedTime: formattedTime),
            Spacer(),
            RecieveMessageWidget(formattedTime: formattedTime),
            Spacer(),
            SendMessagWidgetButtons(messageController: messageController),
          ],
        ),
      ),
    );
  }
}
