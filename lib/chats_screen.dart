import 'package:flutter/material.dart';
import 'package:mozz_chat_app/message_model.dart';
import 'package:provider/provider.dart';
import 'package:mozz_chat_app/chat_screen.dart';
import 'package:mozz_chat_app/widgets/app_bar_title_widget.dart';
import 'package:mozz_chat_app/widgets/app_chat_widget_row.dart';
import 'package:mozz_chat_app/widgets/app_search_field_widget.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'chats_provider.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatsProvider(),
      child: Consumer<ChatsProvider>(
        builder: (context, chatsProvider, _) {
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
                    controller: chatsProvider.searchController,
                    focusNode: chatsProvider.searchFocusNode,
                  ),
                  SizedBox(height: 24),
                  Divider(color: AppColors.textFieldColor),
                  Expanded(
                    child: ListView.builder(
                      itemCount: chatsProvider.filteredChats.length,
                      itemBuilder: (BuildContext context, int index) {
                        final chat = chatsProvider.filteredChats[index];
                        final chatId = chatsProvider.getChatId(chat.firstName, chat.lastName);
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
                            chatsProvider.deleteChat(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Чат с ${chat.firstName} ${chat.lastName} удален"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: FutureBuilder<Message?>(
                            future: chatsProvider.getLastMessage(chatId),
                            builder: (context, snapshot) {
                              final lastMessage = snapshot.data;
                              return GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        firstName: chat.firstName,
                                        lastName: chat.lastName,
                                        color1: chat.color1,
                                        color2: chat.color2,
                                        onReturn: () {},
                                      ),
                                    ),
                                  );
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
        },
      ),
    );
  }
}
