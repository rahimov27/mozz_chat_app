import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class SendedMessageWidget extends StatelessWidget {
  final String message;
  SendedMessageWidget({
    super.key,
    required this.formattedTime,
    required this.message,
  });

  final String formattedTime;
  final DateTime date = DateTime.now();
  final formateDate = DateFormat('dd:MM.yy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(child: Container(color: AppColors.gray, height: 1)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  formateDate,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    color: AppColors.gray,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(child: Container(color: AppColors.gray, height: 1)),
            ],
          ),
        ),
        SizedBox(height: 20),
        ChatBubble(
          margin: EdgeInsets.only(right: 20),
          alignment: Alignment.topRight,
          shadowColor: Colors.transparent,
          clipper: ChatBubbleClipper2(
            type: BubbleType.sendBubble,
            radius: 21,
            nipRadius: 0,
          ),
          backGroundColor: AppColors.chatGreen,
          child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.chatTextDarkGreen,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.chatTextDarkGreen,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4),

                SvgPicture.asset("assets/svg/read.svg"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
