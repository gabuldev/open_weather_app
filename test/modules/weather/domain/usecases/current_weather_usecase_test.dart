import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather_app/modules/weather/domain/services/weather_service.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/current_weather_usecase.dart';

import '../../../../fixture/entities/entities_mock.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

class WeatherServiceMock extends Mock implements WeatherService {}

void main() {
  late final CurrentWeatherUseCase useCase;
  late final WeatherService service;
  late final WeatherRepository repository;

  setUpAll(() {
    service = WeatherServiceMock();
    repository = WeatherRepositoryMock();
    useCase = CurrentWeatherUseCase(repository: repository, service: service);
  });

  group("CurrentWeatherUseCase Test", () {
    test("Get a current weather with success", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => service.currentLocation())
          .thenAnswer((_) => Future.value(location));
      when(() => repository.getCurrentWeather(
              lat: location.lat, lon: location.lon))
          .thenAnswer((_) => Future.value(EntitiesMock.weather()));
      final response = await useCase();

      expect(response, equals(EntitiesMock.weather()));
    });

    test("Get a current weather with exception on currentLocation", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => service.currentLocation())
          .thenThrow(Exception("Don't have GPS permission!"));
      when(() => repository.getCurrentWeather(
              lat: location.lat, lon: location.lon))
          .thenAnswer((_) => Future.value(EntitiesMock.weather()));
      try {
        await useCase();
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have GPS permission!");
      }
    });

    test("Get a current weather with exception on getCurrentWeather", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => service.currentLocation())
          .thenAnswer((_) => Future.value(location));
      when(() => repository.getCurrentWeather(
              lat: location.lat, lon: location.lon))
          .thenThrow(Exception("Don't have weather on this location"));
      try {
        await useCase();
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have weather on this location");
      }
    });
  });
}
