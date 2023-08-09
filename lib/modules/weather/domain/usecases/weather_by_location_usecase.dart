import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';

class WeatherByLocationUseCase {
  final WeatherRepository repository;

  WeatherByLocationUseCase({
    required this.repository,
  });

  Future<WeatherEntity> call(
      {required double? lat, required double? lon}) async {
    if (lat == null && lon == null) {
      throw Exception("Lat and Lon is null!");
    }

    final response = await repository.getCurrentWeather(lat: lat!, lon: lon!);
    return response;
  }
}
