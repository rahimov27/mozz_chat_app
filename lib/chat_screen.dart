import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:mozz_chat_app/chat_provider.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/chat_app_bar_widget.dart';
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
    return ChangeNotifierProvider(
      create: (_) => ChatProvider()..initBox(firstName, lastName),
      child: Consumer<ChatProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final groupedMessages = provider.groupMessagesByDate(
            provider.chatBox.values.toList(),
          );

          return Scaffold(
            appBar: AppBar(
              leadingWidth: 0,
              surfaceTintColor: Colors.transparent,
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: groupedMessages.length,
                      itemBuilder: (context, index) {
                        final date = groupedMessages.keys.elementAt(index);
                        final messages = groupedMessages[date]!;
                        return Column(
                          children: [
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
                            ...messages.map((message) {
                              final key = provider.chatBox.keys.firstWhere(
                                (k) => provider.chatBox.get(k) == message,
                              );
                              return SendedMessageWidget(
                                formattedTime: message.timeStamp,
                                message: message.text,
                                isImage: message.imagePath != null,
                                imagePath: message.imagePath,
                                messageKey: key,
                                onDelete: (key) {
                                  provider.chatBox.delete(key);
                                },
                              );
                            }),
                          ],
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
                          onTap: provider.pickImage,
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
                                if (value.trim().isNotEmpty ||
                                    provider.imagePath != null) {
                                  provider.saveMessage(value, provider.imagePath);
                                }
                              },
                              controller: provider.messageController,
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
                              onTap: provider.clearMessages,
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
        },
      ),
    );
  }
}
