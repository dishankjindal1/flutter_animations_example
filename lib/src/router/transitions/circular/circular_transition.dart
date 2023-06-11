import 'package:flutter/material.dart';

class CircularTransition extends StatelessWidget {
  const CircularTransition(
      {required this.animation, required this.child, super.key});

  final int animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircularTransitionClipper(animation),
      child: child,
    );
  }
}

class CircularTransitionClipper extends CustomClipper<Rect> {
  final int animationValue;

  const CircularTransitionClipper(this.animationValue);

  @override
  Rect getClip(Size size) {
    final double radius = animationValue.toDouble();
    final double diameter = radius * 2;
    return Rect.fromLTWH(
      (size.width / 2) - radius,
      (size.height / 2) - radius,
      diameter,
      diameter,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
