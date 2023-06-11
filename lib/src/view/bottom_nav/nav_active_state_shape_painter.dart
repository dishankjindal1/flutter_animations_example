import 'package:even_assignment/src/utility/utility.dart';
import 'package:flutter/material.dart';

class NavActiveStateShapePainter extends CustomPainter {
  final double animatedHeight;
  final NavType navType;

  NavActiveStateShapePainter(
    this.animatedHeight,
    this.navType,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Left
    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.5, 0)
      ..cubicTo(
        size.width * 1.0,
        size.height * 0.0,
        size.width * 1.0,
        size.height * 1.0,
        size.width * 1.5,
        size.height * 1.0,
      )
      ..lineTo(size.width * 0, size.height)
      ..close();

    // Middle
    final middlePath = Path()
      ..moveTo(size.width * -0.5, size.height * 1.0)
      ..cubicTo(
        size.width * 0.25,
        size.height * 1.0,
        size.width * 0.0,
        size.height * 0,
        size.width * 0.5,
        size.height * 0,
      )
      ..cubicTo(
        size.width * 1.0,
        size.height * 0.0,
        size.width * 0.75,
        size.height * 1.0,
        size.width * 1.5,
        size.height * 1.0,
      )
      ..close();

    // Right
    final rightPath = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width * 1.0, 0)
      ..lineTo(size.width * 0.5, 0)
      ..cubicTo(
        size.width * 0.0,
        size.height * 0.0,
        size.width * 0.0,
        size.height * 1.0,
        size.width * -0.5,
        size.height * 1.0,
      )
      ..lineTo(0, size.height)
      ..close();

    if (navType == NavType.left) {
      canvas.drawPath(leftPath, paint);
    } else if (navType == NavType.right) {
      canvas.drawPath(rightPath, paint);
    } else {
      canvas.drawPath(middlePath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
