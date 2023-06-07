import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationCtrl;

  late Animation<double> animatedFontSize;
  late Animation<double> animatedFontWeight;

  late Animation<double> animatedIncomingMove;
  late Animation<double> animatedScale;

  @override
  void initState() {
    super.initState();
    animationCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2, milliseconds: 500))
      ..forward();

    animationCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushNamed('/');
      }
    });

    animatedFontSize = Tween<double>(begin: 12, end: 18).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: const Interval(
          0,
          0.6,
          curve: Curves.linear,
        ),
      ),
    );
    animatedFontWeight = Tween<double>(begin: 1, end: 10).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: const Interval(
          0,
          0.6,
          curve: Curves.linear,
        ),
      ),
    );

    animatedIncomingMove = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.slowMiddle,
        ),
      ),
    );

    animatedScale = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.slowMiddle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (animationCtrl.status == AnimationStatus.completed) {
          Navigator.of(context).pushNamed('/');
        }
      },
      child: Material(
        color: const Color(0xFFC4C4C4),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: AnimatedBuilder(
                animation: animationCtrl,
                builder: (context, _) {
                  return Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                        child: Text(
                          'Beautiful Animations',
                          style: TextStyle(
                            fontSize: animatedFontSize.value,
                            fontWeight: FontWeight.lerp(
                              FontWeight.w100,
                              FontWeight.w900,
                              animationCtrl.value,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(animatedIncomingMove.value, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 100),
                          child: Text(
                            'Incoming',
                            style: TextStyle(
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
