import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/services/weather_service.dart';

class SaveFavoritesCitiesUseCase {
  final WeatherService service;

  SaveFavoritesCitiesUseCase({
    required this.service,
  });

  Future<bool> call(List<CityEntity> cities) async {
    await service.saveCities(cities);
    return true;
  }
}
