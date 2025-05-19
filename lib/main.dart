import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insomnia_app/utils/localization-service.dart';
import 'screens/splash_screens.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const IsomnicApp());
}

class IsomnicApp extends StatelessWidget {
  const IsomnicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      translations: LocalizationService(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('id', 'ID'),
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [Locale('en', 'US'), Locale('id', 'ID')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
