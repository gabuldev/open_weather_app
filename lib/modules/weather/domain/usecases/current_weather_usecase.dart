import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather_app/modules/weather/domain/services/weather_service.dart';

class CurrentWeatherUseCase {
  final WeatherRepository repository;
  final WeatherService service;

  CurrentWeatherUseCase({
    required this.repository,
    required this.service,
  });

  Future<WeatherEntity> call() async {
    final location = await service.currentLocation();
    final response = await repository.getCurrentWeather(
        lat: location.lat, lon: location.lon);
    return response;
  }
}
