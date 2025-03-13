import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class SendedMessageWidget extends StatelessWidget {
  final String message;
  final formateDate = DateFormat('dd:MM.yy').format(DateTime.now());
  final bool isImage;
  final String? imagePath;

  SendedMessageWidget({
    super.key,
    required this.formattedTime,
    required this.message,
    required this.isImage,
    required this.imagePath,
  });

  final String formattedTime;

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
          // padding: EdgeInsets.all(10),
          alignment: Alignment.bottomRight,
          shadowColor: Colors.transparent,
          clipper: ChatBubbleClipper2(
            type: BubbleType.sendBubble,
            radius: 23,
            nipRadius: 0,
          ),
          backGroundColor: AppColors.chatGreen,
          child:
              isImage
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(imagePath!),
                      width: 274, // Set width limit
                      height: 160, // Set height limit
                      fit: BoxFit.cover, // Ensure the image scales correctly
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Expanded(
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
                            overflow:
                                TextOverflow.ellipsis, // For text truncation
                            maxLines: 1,
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
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
