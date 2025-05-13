import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'screens/splash_screens.dart';

void main() {
  runApp(const IsomnicApp());
}

class IsomnicApp extends StatelessWidget {
  const IsomnicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Ganti MaterialApp dengan GetMaterialApp
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
