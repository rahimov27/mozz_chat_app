import 'package:flutter/material.dart';
import 'package:mozz_chat_app/chat_screen.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/app_bar_title_widget.dart';
import 'package:mozz_chat_app/widgets/app_chat_widget_row.dart';
import 'package:mozz_chat_app/widgets/app_search_field_widget.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  final List<AppChatWidgetRow> chats = [
    AppChatWidgetRow(
      firstName: "Виктор",
      lastName: "Власов",
      date: "Вчера",
      color1: AppColors.green1,
      color2: AppColors.green2,
    ),
    AppChatWidgetRow(
      firstName: "Саша",
      lastName: "Алексеев",
      date: "12.01.22",
      color1: AppColors.red1,
      color2: AppColors.red2,
    ),
    AppChatWidgetRow(
      firstName: "Пётр",
      lastName: "Жаринов",
      date: "2 минуты назад",
      color1: AppColors.green1,
      color2: AppColors.green2,
    ),
    AppChatWidgetRow(
      firstName: "Алина",
      lastName: "Жукова",
      date: "09:23",
      color1: AppColors.red1,
      color2: AppColors.red2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarTitleWidget(), centerTitle: false),
      body: SafeArea(
        child: Column(
          children: [
            AppSearchFieldWidget(),
            SizedBox(height: 24),
            Divider(color: AppColors.textFieldColor),
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ChatScreen(
                                firstName: chats[index].firstName,
                                lastName: chats[index].lastName,
                                color1: chats[index].color1,
                                color2: chats[index].color2,
                              ),
                        ),
                      );
                    },
                    child: AppChatWidgetRow(
                      firstName: chats[index].firstName,
                      lastName: chats[index].lastName,
                      date: chats[index].date,
                      color1: chats[index].color1,
                      color2: chats[index].color2,
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
