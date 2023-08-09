import 'dart:convert';

import 'package:open_weather_app/modules/weather/domain/entities/city_entity.dart';

extension CityEntityExtention on CityEntity {
  CityModel toModel() => CityModel(
        name: name,
        country: country,
        lat: lat,
        lon: lon,
        state: state,
        isFavorite: isFavorite,
      );
}

extension CityModelExtention on CityModel {
  CityEntity toEntity() => CityEntity(
        name: name,
        country: country,
        lat: lat,
        lon: lon,
        state: state,
        isFavorite: isFavorite,
      );
}

class CityModel extends CityEntity {
  CityModel({
    super.name,
    super.lat,
    super.lon,
    super.country,
    super.state,
    super.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
      'isFavorite': isFavorite,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
        name: map['name'] != null ? map['name'] as String : null,
        lat: map['lat'] != null ? map['lat'] as double : null,
        lon: map['lon'] != null ? map['lon'] as double : null,
        country: map['country'] != null ? map['country'] as String : null,
        state: map['state'] != null ? map['state'] as String : null,
        isFavorite: map['isFavorite'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
