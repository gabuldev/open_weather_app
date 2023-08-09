import 'package:flutter/material.dart';
import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/current_weather_usecase.dart';
import 'package:open_weather_app/modules/weather/external/datasources/weather_remote_datasource.dart';
import 'package:open_weather_app/modules/weather/external/drivers/weather_local_driver.dart';
import 'package:open_weather_app/modules/weather/infra/repositories/weather_repository_impl.dart';
import 'package:open_weather_app/modules/weather/infra/services/weather_service_impl.dart';
import 'package:open_weather_app/modules/weather/presentation/widgets/current_weather/current_weather_controller.dart';
import 'package:open_weather_app/shared/services/custom_dio/custom_dio.dart';
import 'package:open_weather_app/shared/services/http/http_dio_impl.dart';

class CurrentWeatherWidget extends StatefulWidget {
  const CurrentWeatherWidget({
    super.key,
  });

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  final controller = CurrentWeatherController(
      currentWeatherUseCase: CurrentWeatherUseCase(
          service: WeatherServiceImpl(driver: WeatherLocalDriverImpl()),
          repository: WeatherRepositoryImpl(
              datasource: WeatherRemoteDatasourceImpl(
                  client: HTTPDioImpl(dio: getDioInstance())))));

  @override
  void initState() {
    controller.getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<WeatherEntity?>(
        valueListenable: controller.weatherNotifier,
        builder: (_, value, __) {
          if (value != null) {
            return Text(
                "Current location: ${value.main} - ${value.description}");
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
