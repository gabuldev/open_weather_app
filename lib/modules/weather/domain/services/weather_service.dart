import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';

abstract class WeatherService {
  Future<({double lat, double lon})> currentLocation();

  Future<bool> saveCities(List<CityEntity> cities);

  Future<List<CityEntity>> getCities();
}
