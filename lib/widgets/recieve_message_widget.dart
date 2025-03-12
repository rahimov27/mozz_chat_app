import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class RecieveMessageWidget extends StatelessWidget {
  const RecieveMessageWidget({super.key, required this.formattedTime});

  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      margin: EdgeInsets.only(left: 20),
      alignment: Alignment.topLeft,
      shadowColor: Colors.transparent,
      clipper: ChatBubbleClipper2(
        type: BubbleType.receiverBubble,
        radius: 21,
        nipRadius: 0,
      ),
      backGroundColor: AppColors.textFieldColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Уже сделал?",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 12),
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.black,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
