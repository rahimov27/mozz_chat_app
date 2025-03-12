import 'package:flutter/material.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/app_chat_widget_row.dart';
import 'package:mozz_chat_app/widgets/app_search_field_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Чаты",
          style: TextStyle(
            fontSize: 32,
            fontFamily: "Gilroy-bold",
            letterSpacing: 0,
            color: AppColors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppSearchFieldWidget(),
            SizedBox(height: 24),
            Divider(color: AppColors.textFieldColor),
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
              firstName: "Пётр",
              lastName: "Жаринов",
              date: "09:23",
              color1: AppColors.red1,
              color2: AppColors.red2,
            ),
          ],
        ),
      ),
    );
  }
}
