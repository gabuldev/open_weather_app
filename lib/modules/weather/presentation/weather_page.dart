import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/presentation/weather_controller.dart';
import 'package:open_weather_app/modules/weather/presentation/widgets/city/city_widget.dart';
import 'package:open_weather_app/modules/weather/presentation/widgets/current_weather/current_weather_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final controller = GetIt.I.get<WeatherController>();
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
