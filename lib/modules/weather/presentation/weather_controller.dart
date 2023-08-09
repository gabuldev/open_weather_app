import 'package:flutter/foundation.dart';
import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/current_weather_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/get_saved_cities_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/save_favorite_city_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/search_city_usecase.dart';

class WeatherController {
  final SearchCityUseCase searchCityUseCase;
  final SaveFavoritesCitiesUseCase saveFavoritesCitiesUseCase;
  final GetSavedCitiesUseCase getSavedCitiesUseCase;
  final CurrentWeatherUseCase currentWeatherUseCase;

  WeatherController({
    required this.searchCityUseCase,
    required this.saveFavoritesCitiesUseCase,
    required this.getSavedCitiesUseCase,
    required this.currentWeatherUseCase,
  });

  final citiesNotifier = ValueNotifier<List<CityEntity>>([]);
  List<CityEntity> get cities => citiesNotifier.value;
  set cities(List<CityEntity> value) => citiesNotifier.value = value;

  Future<void> initSavedCities() async {
    final response = await getSavedCitiesUseCase();
    cities = response;
  }

  Future<void> search(String param) async {
    if (param.isNotEmpty && param.length >= 3) {
      final response = await searchCityUseCase(param);
      cities = response;
    } else {
      cities = await getSavedCitiesUseCase();
    }
  }

  Future<void> favoriteCity(CityEntity city) async {
    final citiesSaved = await getSavedCitiesUseCase();
    final isFavorite = !city.isFavorite;
    final newCity = city.copyWith(isFavorite: isFavorite);

    if (isFavorite) {
      citiesSaved.add(newCity);
    } else {
      citiesSaved.remove(city);
    }
    await saveFavoritesCitiesUseCase(citiesSaved);

    cities = [];
    cities = citiesSaved;
  }
}
