import 'package:flutter/widgets.dart';
import 'package:open_weather_app/modules/weather/presentation/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: WeatherPage());
  }
}
