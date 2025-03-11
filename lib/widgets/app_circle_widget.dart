import 'package:flutter/material.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class AppCircleWidget extends StatelessWidget {
  const AppCircleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.green1, AppColors.green2],
            ),
          ),
        ),
      ],
    );
  }
}
