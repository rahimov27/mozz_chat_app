import 'package:flutter/material.dart';

class ChatBubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 16.0;

    // Верхний левый угол
    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Нижний правый "хвостик"
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );
    path.lineTo(radius, size.height);

    // "Хвостик"
    path.lineTo(radius - 15, size.height + 15);
    path.quadraticBezierTo(
      radius - 20,
      size.height,
      radius - 12,
      size.height - 5,
    );

    // Нижний левый угол
    path.lineTo(radius - 12, radius);
    path.quadraticBezierTo(radius - 12, 0, radius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
