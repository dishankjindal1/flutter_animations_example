import 'package:even_assignment/src/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.clear();

  runApp(const MyApp());
}
