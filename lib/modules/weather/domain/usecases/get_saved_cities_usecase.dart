import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';

import '../services/weather_service.dart';

class GetSavedCitiesUseCase {
  final WeatherService service;

  GetSavedCitiesUseCase({
    required this.service,
  });

  Future<List<CityEntity>> call() async {
    final response = await service.getCities();
    return response;
  }
}
