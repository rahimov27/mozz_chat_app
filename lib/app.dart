import 'package:flutter/material.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/app_circle_widget.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  AppCircleWidget(),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Виктор Власов",
                        style: TextStyle(
                          fontFamily: "Gilroy-bold",
                          letterSpacing: 0,
                          fontSize: 15,
                          color: AppColors.blackColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Вы:",
                            style: TextStyle(
                              fontFamily: "Gilroy",
                              letterSpacing: 0,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Уже сделал?",
                            style: TextStyle(
                              fontFamily: "Gilroy",
                              letterSpacing: 0,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
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
