import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';

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
  final controller = GetIt.I.get<CityController>();

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
      subtitle: ValueListenableBuilder<CityStatus>(
          valueListenable: controller.weatherNotifier,
          builder: (_, value, __) {
            if (value.data != null) {
              return Text("${value.data!.main} - ${value.data!.description}");
            } else if (value.error != null) {
              return Text("${value.error}");
            } else {
              return const Text("Loading...");
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
