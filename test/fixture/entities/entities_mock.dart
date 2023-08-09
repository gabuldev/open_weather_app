import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';
import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';

class EntitiesMock {
  static WeatherEntity weather() => WeatherEntity(
        id: 501,
        main: "Rain",
        description: "moderate rain",
        icon: "10d",
      );

  static List<CityEntity> cities() => [
        CityEntity(
            name: "London",
            lat: 37.1289771,
            lon: -84.0832646,
            country: "US",
            state: "Kentucky")
      ];
}
