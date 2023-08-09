import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_app/modules/weather/domain/services/weather_service.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/get_saved_cities_usecase.dart';

import '../../../../fixture/entities/entities_mock.dart';

class WeatherServiceMock extends Mock implements WeatherService {}

void main() {
  late final GetSavedCitiesUseCase useCase;
  late final WeatherService service;

  setUpAll(() {
    service = WeatherServiceMock();
    useCase = GetSavedCitiesUseCase(service: service);
  });

  group("SearchCityUseCase Test", () {
    test("Get saved cities with success", () async {
      when(() => service.getCities())
          .thenAnswer((_) => Future.value(EntitiesMock.cities()));
      final response = await useCase();

      expect(response, equals(EntitiesMock.cities()));
    });

    test("Get saved cities with failure", () async {
      when(() => service.getCities())
          .thenThrow(Exception("Don't have any city"));
      try {
        await useCase();
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have any city");
      }
    });
  });
}
