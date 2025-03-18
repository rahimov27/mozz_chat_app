import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/app_circle_widget.dart';

class ChatAppBarWidget extends StatelessWidget {
  const ChatAppBarWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.color1,
    required this.color2,
  });

  final String firstName;
  final String lastName;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context, true),
          child: SvgPicture.asset(
            "assets/svg/arrow-back.svg",
            width: 36,
            height: 36,
          ),
        ),
        SizedBox(width: 6),
        AppCircleWidget(
          firstName: firstName,
          lastName: lastName,
          color1: color1,
          color2: color2,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$firstName $lastName",
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
                  "В сети",
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
    );
  }
}
