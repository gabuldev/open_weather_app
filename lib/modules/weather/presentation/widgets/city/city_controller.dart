// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/weather_by_location_usecase.dart';

class CityController {
  final WeatherByLocationUseCase weatherByLocationUseCase;
  CityController({
    required this.weatherByLocationUseCase,
  });

  final weatherNotifier = ValueNotifier<WeatherEntity?>(null);
  WeatherEntity? get weather => weatherNotifier.value;
  set weather(WeatherEntity? value) => weatherNotifier.value = value;

  void getWeather(CityEntity city) async {
    final response =
        await weatherByLocationUseCase(lat: city.lat, lon: city.lon);
    weather = response;
  }
}
