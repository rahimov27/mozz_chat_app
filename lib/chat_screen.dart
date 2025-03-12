import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/chat_app_bar_widget.dart';

class ChatScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final Color color1;
  final Color color2;
  const ChatScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: ChatAppBarWidget(
          firstName: firstName,
          lastName: lastName,
          color1: color1,
          color2: color2,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(color: AppColors.textFieldColor),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 23, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.textFieldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: SvgPicture.asset("assets/svg/attach.svg"),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray,
                        ),
                        decoration: InputDecoration(
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                          contentPadding: EdgeInsets.only(left: 12),
                          hintText: "Сообщение",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w500,
                            color: AppColors.gray,
                          ),
                          fillColor: Color(0xffEDF2F6),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.textFieldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: SvgPicture.asset("assets/svg/audio.svg"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
