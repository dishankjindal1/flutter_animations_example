import 'package:even_assignment/src/router/router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0055FF)),
        useMaterial3: true,
      ),
      navigatorObservers: [
        RouteObserver(),
      ],
      initialRoute: '/splash',
      onGenerateRoute: MyRouter.router,
    );
  }
}
