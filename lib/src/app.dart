import 'package:even_assignment/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final RouteObserver<ModalRoute<dynamic>> routeObserver = RouteObserver<ModalRoute<dynamic>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.exo2TextTheme(),
        dividerTheme: const DividerThemeData(
          color: Color.fromRGBO(102, 102, 102, 1),
          thickness: 0.5,
        ),
      ),
      navigatorObservers: [routeObserver],
      initialRoute: '/splash',
      onGenerateRoute: MyRouter.router,
    );
  }
}
