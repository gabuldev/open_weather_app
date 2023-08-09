import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/weather_by_location_usecase.dart';

import '../../../../fixture/entities/entities_mock.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

void main() {
  late final WeatherByLocationUseCase useCase;
  late final WeatherRepository repository;

  setUpAll(() {
    repository = WeatherRepositoryMock();
    useCase = WeatherByLocationUseCase(repository: repository);
  });

  group("WeatherByLocationUseCase Test", () {
    test("Get a weather with success", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => repository.getCurrentWeather(
              lat: location.lat, lon: location.lon))
          .thenAnswer((_) => Future.value(EntitiesMock.weather()));
      final response = await useCase(lat: location.lat, lon: location.lon);

      expect(response, equals(EntitiesMock.weather()));
    });

    test("Get a current weather with exception on currentLocation", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => repository.getCurrentWeather(
              lat: location.lat, lon: location.lon))
          .thenThrow(Exception("Don't have weather on this location"));
      try {
        await useCase(lat: location.lat, lon: location.lon);
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have weather on this location");
      }
    });
  });
}
