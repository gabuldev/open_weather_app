import 'package:flutter/material.dart';
import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/current_weather_usecase.dart';

class CurrentWeatherController {
  final CurrentWeatherUseCase currentWeatherUseCase;
  CurrentWeatherController({
    required this.currentWeatherUseCase,
  });

  final weatherNotifier = ValueNotifier<WeatherEntity?>(null);
  WeatherEntity? get weather => weatherNotifier.value;
  set weather(WeatherEntity? value) => weatherNotifier.value = value;

  void getCurrentWeather() async {
    final response = await currentWeatherUseCase();
    weather = response;
  }
}
