import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Color(0xFFC4C4C4),
      child: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
