import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_app/modules/weather/domain/services/weather_service.dart';
import 'package:open_weather_app/modules/weather/infra/drivers/weather_driver.dart';
import 'package:open_weather_app/modules/weather/infra/services/weather_service_impl.dart';

import '../../../../fixture/entities/entities_mock.dart';
import '../../../../fixture/entities/models_mock.dart';

class WeatherDriverMock extends Mock implements WeatherDriver {}

void main() {
  late final WeatherDriver driver;
  late final WeatherService service;

  setUpAll(() {
    driver = WeatherDriverMock();
    service = WeatherServiceImpl(driver: driver);
  });

  group("WeatherServiceImplImpl Test", () {
    test("Get a current location with success", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => driver.currentLocation())
          .thenAnswer((_) => Future.value(location));

      final response = await service.currentLocation();

      expect(response, equals(location));
    });

    test("Get a current location with an exception", () async {
      when(() => driver.currentLocation())
          .thenThrow(Exception("Don't have any location"));
      try {
        await service.currentLocation();
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have any location");
      }
    });

    test("Get cities with success", () async {
      when(() => driver.getCities())
          .thenAnswer((_) => Future.value(ModelsMock.cities()));

      final response = await service.getCities();

      expect(response, equals(EntitiesMock.cities()));
    });

    test("Get cities with failure", () async {
      when(() => driver.getCities())
          .thenThrow(Exception("Don't have any city"));
      try {
        await service.getCities();
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have any city");
      }
    });

    test("Save cities with success", () async {
      final cities = ModelsMock.cities();
      when(() => driver.saveCities(cities))
          .thenAnswer((_) => Future.value(true));

      final response = await service.saveCities(EntitiesMock.cities());
      expect(response, isTrue);
    }, skip: true);

    test("Save cities with failure", () async {
      when(() => driver.saveCities(ModelsMock.cities()))
          .thenThrow(Exception("Don't save cities"));
      try {
        await service.saveCities(EntitiesMock.cities());
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't save cities");
      }
    }, skip: true);
  });
}
