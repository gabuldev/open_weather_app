import 'package:flutter/material.dart';
import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/current_weather_usecase.dart';

class CurrentWeatherStatus {
  String? error;
  bool loading;
  WeatherEntity? data;
  CurrentWeatherStatus({
    this.error,
    this.loading = false,
    this.data,
  });
}

class CurrentWeatherController {
  final CurrentWeatherUseCase currentWeatherUseCase;
  CurrentWeatherController({
    required this.currentWeatherUseCase,
  });

  final weatherNotifier =
      ValueNotifier<CurrentWeatherStatus>(CurrentWeatherStatus());
  CurrentWeatherStatus get weather => weatherNotifier.value;
  set weather(CurrentWeatherStatus value) => weatherNotifier.value = value;

  void getCurrentWeather() async {
    try {
      final response = await currentWeatherUseCase();
      weather = CurrentWeatherStatus(data: response);
    } catch (e) {
      weather =
          CurrentWeatherStatus(error: "Something wrong, try again later!");
    }
  }
}
