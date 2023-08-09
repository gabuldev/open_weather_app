import 'dart:convert';

import 'package:open_weather_app/modules/weather/domain/entities/weather_entity.dart';

extension WeatherEntityExtention on WeatherEntity {
  WeatherEntity toModel() => WeatherEntity(
        description: description,
        icon: icon,
        id: id,
        main: main,
      );
}

class WeatherModel extends WeatherEntity {
  WeatherModel({
    super.id,
    super.main,
    super.description,
    super.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      id: map['id'] != null ? map['id'] as int : null,
      main: map['main'] != null ? map['main'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
