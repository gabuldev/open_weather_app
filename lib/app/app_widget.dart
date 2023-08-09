import 'package:flutter/material.dart';
import 'package:open_weather_app/modules/home/presentation/home_page.dart';
import 'package:open_weather_app/modules/splash/presentation/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}
