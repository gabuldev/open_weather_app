import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';

class SearchCityUseCase {
  final WeatherRepository repository;

  SearchCityUseCase({
    required this.repository,
  });

  Future<List<CityEntity>> call(String name) async {
    final response = await repository.searchCity(name);
    return response;
  }
}
