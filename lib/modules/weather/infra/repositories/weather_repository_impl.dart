import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather_app/modules/weather/infra/datasources/weather_datasource.dart';
import 'package:open_weather_app/modules/weather/infra/models/city_model.dart';
import 'package:open_weather_app/modules/weather/infra/models/weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDatasource datasource;
  WeatherRepositoryImpl({
    required this.datasource,
  });
  @override
  Future<WeatherEntity> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    final response = await datasource.getCurrentWeather(lat: lat, lon: lon);
    return WeatherModel.fromMap(response);
  }

  @override
  Future<List<CityEntity>> searchCity(String name) async {
    final response = await datasource.searchCity(name);
    return (response).map((e) => CityModel.fromMap(e).toEntity()).toList();
  }
}
