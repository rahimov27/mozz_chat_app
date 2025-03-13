import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class SendedMessageWidget extends StatelessWidget {
  final String message;
  final String formattedTime;
  final bool isImage;
  final String? imagePath;

  const SendedMessageWidget({
    super.key,
    required this.formattedTime,
    required this.message,
    required this.isImage,
    this.imagePath,
  });

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
                  DateFormat('dd:MM.yy').format(DateTime.now()),
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
          padding: isImage ? EdgeInsets.only(top: 4, right: 14) : null,
          margin: EdgeInsets.only(right: 20),
          alignment: Alignment.bottomRight,
          shadowColor: Colors.transparent,
          clipper: ChatBubbleClipper2(
            type: BubbleType.sendBubble,
            radius: 23,
            nipRadius: 0,
          ),
          backGroundColor: AppColors.chatGreen,
          child: Padding(
            padding:
                isImage
                    ? const EdgeInsets.only(left: 6, right: 0)
                    : EdgeInsets.only(left: 6, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isImage)
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(19),
                      topLeft: Radius.circular(19),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    child: Image.file(
                      File(imagePath!),
                      width: 274,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 282),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isImage
                          ? Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      isImage
                                          ? const EdgeInsets.only(
                                            top: 8,
                                            left: 10,
                                            bottom: 6,
                                            right: 4,
                                          )
                                          : EdgeInsets.all(0),
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    message,
                                    style: TextStyle(
                                      overflow: TextOverflow.visible,
                                      fontSize: 14,
                                      color: AppColors.chatTextDarkGreen,
                                      fontFamily: "Gilroy",
                                      fontWeight: FontWeight.w500,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Spacer(),
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 2,
                                    right: 10,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/svg/read.svg",
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding:
                                      isImage
                                          ? const EdgeInsets.only(top: 8)
                                          : EdgeInsets.all(0),
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    message,
                                    style: TextStyle(
                                      overflow: TextOverflow.visible,
                                      fontSize: 14,
                                      color: AppColors.chatTextDarkGreen,
                                      fontFamily: "Gilroy",
                                      fontWeight: FontWeight.w500,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
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
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: SvgPicture.asset("assets/svg/read.svg"),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
