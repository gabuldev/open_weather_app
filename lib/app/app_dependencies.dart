import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather_app/modules/weather/domain/services/weather_service.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/current_weather_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/get_saved_cities_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/save_favorite_city_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/search_city_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/weather_by_location_usecase.dart';
import 'package:open_weather_app/modules/weather/external/datasources/weather_remote_datasource.dart';
import 'package:open_weather_app/modules/weather/external/drivers/weather_local_driver.dart';
import 'package:open_weather_app/modules/weather/infra/datasources/weather_datasource.dart';
import 'package:open_weather_app/modules/weather/infra/drivers/weather_driver.dart';
import 'package:open_weather_app/modules/weather/infra/repositories/weather_repository_impl.dart';
import 'package:open_weather_app/modules/weather/infra/services/weather_service_impl.dart';
import 'package:open_weather_app/modules/weather/presentation/weather_controller.dart';
import 'package:open_weather_app/modules/weather/presentation/widgets/city/city_controller.dart';
import 'package:open_weather_app/modules/weather/presentation/widgets/current_weather/current_weather_controller.dart';
import 'package:open_weather_app/shared/services/http/http.dart';
import 'package:open_weather_app/shared/services/http/http_dio_impl.dart';

import '../shared/services/custom_dio/custom_dio.dart';

class AppDependencies {
  static void init() {
    GetIt.I.registerLazySingleton<Dio>(() => getDioInstance());
    GetIt.I.registerLazySingleton<HTTP>(
        () => HTTPDioImpl(dio: GetIt.I.get<Dio>()));
    GetIt.I.registerLazySingleton<WeatherDatasource>(
        () => WeatherRemoteDatasourceImpl(client: GetIt.I.get<HTTP>()));
    GetIt.I.registerLazySingleton<WeatherRepository>(() =>
        WeatherRepositoryImpl(datasource: GetIt.I.get<WeatherDatasource>()));
    GetIt.I.registerLazySingleton<SearchCityUseCase>(
        () => SearchCityUseCase(repository: GetIt.I.get<WeatherRepository>()));
    GetIt.I
        .registerLazySingleton<WeatherDriver>(() => WeatherLocalDriverImpl());
    GetIt.I.registerLazySingleton<WeatherService>(
        () => WeatherServiceImpl(driver: GetIt.I.get<WeatherDriver>()));
    GetIt.I.registerLazySingleton(() =>
        SaveFavoritesCitiesUseCase(service: GetIt.I.get<WeatherService>()));
    GetIt.I.registerLazySingleton(
        () => GetSavedCitiesUseCase(service: GetIt.I.get<WeatherService>()));
    GetIt.I.registerLazySingleton(() => CurrentWeatherUseCase(
        service: GetIt.I.get<WeatherService>(),
        repository: GetIt.I.get<WeatherRepository>()));
    GetIt.I.registerLazySingleton(() =>
        WeatherByLocationUseCase(repository: GetIt.I.get<WeatherRepository>()));

    GetIt.I.registerLazySingleton(() => WeatherController(
        currentWeatherUseCase: GetIt.I.get<CurrentWeatherUseCase>(),
        getSavedCitiesUseCase: GetIt.I.get<GetSavedCitiesUseCase>(),
        saveFavoritesCitiesUseCase: GetIt.I.get<SaveFavoritesCitiesUseCase>(),
        searchCityUseCase: GetIt.I.get<SearchCityUseCase>()));

    GetIt.I.registerLazySingleton(() => CurrentWeatherController(
        currentWeatherUseCase: GetIt.I.get<CurrentWeatherUseCase>()));

    GetIt.I.registerLazySingleton(() => CityController(
        weatherByLocationUseCase: GetIt.I.get<WeatherByLocationUseCase>()));
  }
}
