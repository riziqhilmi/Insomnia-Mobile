import 'package:flutter/material.dart';
import 'screens/splash_screens.dart';

void main() {
  runApp(const IsomnicApp());
}

class IsomnicApp extends StatelessWidget {
  const IsomnicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
