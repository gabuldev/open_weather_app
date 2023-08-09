import 'package:flutter/material.dart';
import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/weather_by_location_usecase.dart';
import 'package:open_weather_app/modules/weather/external/datasources/weather_remote_datasource.dart';
import 'package:open_weather_app/modules/weather/infra/repositories/weather_repository_impl.dart';
import 'package:open_weather_app/shared/services/custom_dio/custom_dio.dart';
import 'package:open_weather_app/shared/services/http/http_dio_impl.dart';

import 'city_controller.dart';

class CityWidget extends StatefulWidget {
  final CityEntity city;
  final VoidCallback tapFavorite;
  const CityWidget({
    super.key,
    required this.city,
    required this.tapFavorite,
  });

  @override
  State<CityWidget> createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  final controller = CityController(
      weatherByLocationUseCase: WeatherByLocationUseCase(
          repository: WeatherRepositoryImpl(
              datasource: WeatherRemoteDatasourceImpl(
                  client: HTTPDioImpl(dio: getDioInstance())))));

  @override
  void initState() {
    controller.getWeather(widget.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        "${widget.city.name} - ${widget.city.state},  ${widget.city.country},",
      ),
      subtitle: ValueListenableBuilder<WeatherEntity?>(
          valueListenable: controller.weatherNotifier,
          builder: (_, value, __) {
            if (value != null) {
              return Text("${value.main} - ${value.description}");
            } else {
              return const SizedBox.shrink();
            }
          }),
      trailing: IconButton(
          onPressed: widget.tapFavorite,
          icon: widget.city.isFavorite
              ? const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                )
              : const Icon(Icons.favorite_outline)),
    );
  }
}
