import 'package:flutter/material.dart';
import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/current_weather_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/get_saved_cities_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/save_favorite_city_usecase.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/search_city_usecase.dart';
import 'package:open_weather_app/modules/weather/external/datasources/weather_remote_datasource.dart';
import 'package:open_weather_app/modules/weather/external/drivers/weather_local_driver.dart';
import 'package:open_weather_app/modules/weather/infra/repositories/weather_repository_impl.dart';
import 'package:open_weather_app/modules/weather/infra/services/weather_service_impl.dart';
import 'package:open_weather_app/modules/weather/presentation/weather_controller.dart';
import 'package:open_weather_app/modules/weather/presentation/widgets/city/city_widget.dart';
import 'package:open_weather_app/modules/weather/presentation/widgets/current_weather/current_weather_widget.dart';
import 'package:open_weather_app/shared/services/custom_dio/custom_dio.dart';
import 'package:open_weather_app/shared/services/http/http_dio_impl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final controller = WeatherController(
      currentWeatherUseCase: CurrentWeatherUseCase(
          repository: WeatherRepositoryImpl(
              datasource: WeatherRemoteDatasourceImpl(
                  client: HTTPDioImpl(dio: getDioInstance()))),
          service: WeatherServiceImpl(driver: WeatherLocalDriverImpl())),
      getSavedCitiesUseCase: GetSavedCitiesUseCase(
          service: WeatherServiceImpl(driver: WeatherLocalDriverImpl())),
      saveFavoritesCitiesUseCase: SaveFavoritesCitiesUseCase(
          service: WeatherServiceImpl(driver: WeatherLocalDriverImpl())),
      searchCityUseCase: SearchCityUseCase(
          repository: WeatherRepositoryImpl(
              datasource: WeatherRemoteDatasourceImpl(
                  client: HTTPDioImpl(dio: getDioInstance())))));
  final textEditingController = TextEditingController();

  @override
  void initState() {
    controller.initSavedCities();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              controller: textEditingController,
              hintText: "Search your favorities cities",
              onChanged: (param) {
                controller.search(param);
              },
            ),
          )),
      body: ValueListenableBuilder<List<CityEntity>>(
          valueListenable: controller.citiesNotifier,
          builder: (_, cities, __) {
            return ListView.builder(
              itemCount: cities.length,
              itemBuilder: (_, index) => CityWidget(
                city: cities[index],
                tapFavorite: () {
                  controller.favoriteCity(cities[index]);
                },
              ),
            );
          }),
      bottomNavigationBar: const CurrentWeatherWidget(),
    );
  }
}
