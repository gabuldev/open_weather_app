import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather_app/modules/weather/domain/usecases/search_city_usecase.dart';

import '../../../../fixture/entities/entities_mock.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

void main() {
  late final SearchCityUseCase useCase;
  late final WeatherRepository repository;

  setUpAll(() {
    repository = WeatherRepositoryMock();
    useCase = SearchCityUseCase(repository: repository);
  });

  group("SearchCityUseCase Test", () {
    test("Get a current weather with success", () async {
      const name = 'London';
      when(() => repository.searchCity(name))
          .thenAnswer((_) => Future.value(EntitiesMock.cities()));
      final response = await useCase(name);

      expect(response, equals(EntitiesMock.cities()));
    });

    test("Get a current weather with exception on currentLocation", () async {
      const name = 'London';
      when(() => repository.searchCity(name))
          .thenThrow(Exception("Don't have city with this name"));
      try {
        await useCase(name);
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have city with this name");
      }
    });
  });
}
