import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/services/weather_service.dart';
import 'package:open_weather_app/modules/weather/infra/drivers/weather_driver.dart';
import 'package:open_weather_app/modules/weather/infra/models/city_model.dart';

class WeatherServiceImpl implements WeatherService {
  final WeatherDriver driver;
  WeatherServiceImpl({
    required this.driver,
  });

  @override
  Future<({double lat, double lon})> currentLocation() async {
    return driver.currentLocation();
  }

  @override
  Future<List<CityEntity>> getCities() async {
    final response = await driver.getCities();
    return response.map((e) => CityModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<bool> saveCities(List<CityEntity> cities) async {
    try {
      final parse = cities.map((e) => e.toModel().toJson()).toList();
      await driver.saveCities(parse);
      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
