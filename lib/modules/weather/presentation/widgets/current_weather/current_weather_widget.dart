import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_weather_app/modules/weather/presentation/widgets/current_weather/current_weather_controller.dart';

class CurrentWeatherWidget extends StatefulWidget {
  const CurrentWeatherWidget({
    super.key,
  });

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  final controller = GetIt.I.get<CurrentWeatherController>();

  @override
  void initState() {
    controller.getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CurrentWeatherStatus>(
        valueListenable: controller.weatherNotifier,
        builder: (_, value, __) {
          if (value.data != null) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Current location: ${value.data!.main} - ${value.data!.description}"),
              ),
            );
          } else if (value.error != null) {
            return Text(value.error!);
          } else {
            return const LinearProgressIndicator();
          }
        });
  }
}
