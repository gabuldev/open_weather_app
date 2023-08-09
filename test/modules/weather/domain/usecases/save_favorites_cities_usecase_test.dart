import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_app/modules/weather/domain/services/weather_service.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/save_favorite_city_usecase.dart';

import '../../../../fixture/entities/entities_mock.dart';

class WeatherServiceMock extends Mock implements WeatherService {}

void main() {
  late final SaveFavoritesCitiesUseCase useCase;
  late final WeatherService service;

  setUpAll(() {
    service = WeatherServiceMock();
    useCase = SaveFavoritesCitiesUseCase(service: service);
  });

  group("SaveFavoritesCitiesUseCase Test", () {
    test("Save favorite city with success", () async {
      when(() => service.saveCities(EntitiesMock.cities()))
          .thenAnswer((_) => Future.value(true));
      final response = await useCase(EntitiesMock.cities());

      expect(response, isTrue);
    });

    test("Save favorite city with failure", () async {
      when(() => service.saveCities(EntitiesMock.cities()))
          .thenThrow(Exception("Can not save this city"));
      try {
        await useCase(EntitiesMock.cities());
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Can not save this city");
      }
    });
  });
}
