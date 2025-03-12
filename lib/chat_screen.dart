import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mozz_chat_app/bloc/send_message_bloc/send_bloc.dart';
import 'package:mozz_chat_app/bloc/send_message_bloc/send_event.dart';
import 'package:mozz_chat_app/bloc/send_message_bloc/send_state.dart';
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
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> messages = [];

  final ScrollController _scrollContrller = ScrollController();

  @override
  Widget build(BuildContext context) {
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
              child: BlocConsumer<SendBloc, SendState>(
                listener: (context, state) {
                  if (state is SendMessageSuccess) {
                    setState(() {
                      messages.insert(0, {
                        "time": DateFormat('HH:mm').format(DateTime.now()),
                        "message": state.successMessage,
                      });
                      // автоматическая прокрутка вниз
                      _scrollToBottom();
                    });
                  } else if (state is SendMessageError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller: _scrollContrller,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return SendedMessageWidget(
                        formattedTime: msg['time']!,
                        message: msg['message']!,
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
                          if (value.trim().isNotEmpty) {
                            context.read<SendBloc>().add(
                              SendMessageEvent(message: value),
                            );
                            messageController.clear();
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

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollContrller.hasClients) {
        _scrollContrller.jumpTo(_scrollContrller.position.minScrollExtent);
      }
    });
  }
}
