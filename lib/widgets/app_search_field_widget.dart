import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';

class AppSearchFieldWidget extends StatelessWidget {
  const AppSearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 42,
        child: TextField(
          cursorColor: AppColors.gray,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w500,
            color: AppColors.gray,
          ),
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: EdgeInsets.all(0),
            hintText: "Поиск",
            hintStyle: TextStyle(
              fontSize: 16,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w500,
              color: AppColors.gray,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                top: 9,
                bottom: 9,
                left: 8,
                right: 0,
              ),
              child: SvgPicture.asset(
                "assets/svg/search.svg",
                width: 24,
                height: 24,
              ),
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
    );
  }
}
