import 'package:even_assignment/src/multi_tab_bottom_app_scaffold.dart';
import 'package:even_assignment/src/view/add_consultation/add_consultation_screen.dart';
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
          pageBuilder: (contex, animation, secondaryAnimation) =>
              AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) {
                    return CircularTransition(
                      animation: (animation.value * 500).toInt(),
                      child: const MultiTabBottomAppScaffold(),
                    );
                  }),
        );
      case '/add_consultation':
        return PageRouteBuilder(
          pageBuilder: (contex, animation, secondaryAnimation) =>
              AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              return CircularTransition(
                animation: (animation.value * 500).toInt(),
                child: const AddConsultationScreen(),
              );
            },
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Placeholder(),
        );
    }
  }
}
