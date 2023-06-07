import 'package:even_assignment/src/view/bottom_nav/bottom_nav_footer.dart';
import 'package:even_assignment/src/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'transitions/circular/circular_transition.dart';

class MyRouter {
  static Route<dynamic> router(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case '/':
        return PageRouteBuilder(
          pageBuilder: (contex, a, b) => AnimatedBuilder(
              animation: a,
              builder: (context, _) {
                return CircularTransition(
                  animation: (a.value * 500).toInt(),
                  child: const BottomNavigationFooter(),
                );
              }),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Placeholder(),
        );
    }
  }
}
