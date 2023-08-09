import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather_app/modules/weather/infra/datasources/weather_datasource.dart';
import 'package:open_weather_app/modules/weather/infra/repositories/weather_repository_impl.dart';

import '../../../../fixture/entities/entities_mock.dart';
import '../../../../fixture/entities/models_mock.dart';

class WeatherDatasourceMock extends Mock implements WeatherDatasource {}

void main() {
  late final WeatherDatasource datasource;
  late final WeatherRepository repository;

  setUpAll(() {
    datasource = WeatherDatasourceMock();
    repository = WeatherRepositoryImpl(datasource: datasource);
  });

  group("WeatherRepositoryImpl Test", () {
    test("Get a current weather with success", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => datasource.getCurrentWeather(
              lat: location.lat, lon: location.lon))
          .thenAnswer((_) => Future.value(ModelsMock.weather()));
      final response = await repository.getCurrentWeather(
          lat: location.lat, lon: location.lon);

      expect(response, equals(EntitiesMock.weather()));
    });

    test("Get a current weather with an exception", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => datasource.getCurrentWeather(
              lat: location.lat, lon: location.lon))
          .thenThrow(Exception("Don't have weather this location"));
      try {
        await repository.getCurrentWeather(
            lat: location.lat, lon: location.lon);
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have weather this location");
      }
    });
  });
}
