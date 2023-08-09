import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';

import '../entities/city_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather(
      {required double lat, required double lon});

  Future<List<CityEntity>> searchCity(String name);
}
