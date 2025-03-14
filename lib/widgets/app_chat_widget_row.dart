import 'package:flutter/material.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/app_circle_widget.dart';

class AppChatWidgetRow extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String date;
  final Color color1;
  final Color color2;
  final String message;

  const AppChatWidgetRow({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.date,
    required this.color1,
    required this.color2,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.textFieldColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 12, bottom: 12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
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
                                message,
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
                  Spacer(),
                  Text(
                    date,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
              // Divider(color: AppColors.textFieldColor, height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
