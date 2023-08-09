import 'package:open_weather_app/shared/services/http/http_status.dart';

abstract class WeatherDatasource {
  Future<JSON> getCurrentWeather({required double lat, required double lon});

  Future<List<JSON>> searchCity(String name);
}
