import 'package:flutter/material.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class AppBarTitleWidget extends StatelessWidget {
  const AppBarTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Чаты",
      style: TextStyle(
        fontSize: 32,
        fontFamily: "Gilroy-bold",
        letterSpacing: 0,
        color: AppColors.black,
      ),
    );
  }
}
