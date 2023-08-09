// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/weather_by_location_usecase.dart';

class CityStatus {
  String? error;
  bool loading;
  WeatherEntity? data;
  CityStatus({
    this.error,
    this.loading = false,
    this.data,
  });
}

class CityController {
  final WeatherByLocationUseCase weatherByLocationUseCase;
  CityController({
    required this.weatherByLocationUseCase,
  });

  final weatherNotifier = ValueNotifier<CityStatus>(CityStatus());
  CityStatus get weather => weatherNotifier.value;
  set weather(CityStatus value) => weatherNotifier.value = value;

  void getWeather(CityEntity city) async {
    try {
      final response =
          await weatherByLocationUseCase(lat: city.lat, lon: city.lon);
      weather = CityStatus(data: response);
    } catch (e) {
      weather = CityStatus(error: e.toString());
    }
  }
}
