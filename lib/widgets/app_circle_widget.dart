import 'package:flutter/material.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class AppCircleWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  const AppCircleWidget({
    super.key,
    required this.firstName,
    required this.lastName,
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
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "${firstName[0].toString().toUpperCase()}${lastName[0].toString().toUpperCase()}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Gilroy-bold",
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
                fontSize: 20,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
