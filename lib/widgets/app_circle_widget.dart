import 'package:flutter/material.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class AppCircleWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final Color color1;
  final Color color2;
  const AppCircleWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.color1,
    required this.color2
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
              colors: [color1, color2],
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
