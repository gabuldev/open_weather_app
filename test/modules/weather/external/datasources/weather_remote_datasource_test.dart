import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_app/modules/weather/external/datasources/weather_remote_datasource.dart';
import 'package:open_weather_app/modules/weather/infra/datasources/weather_datasource.dart';
import 'package:open_weather_app/shared/services/http/http.dart';
import 'package:open_weather_app/shared/services/http/http_status.dart';

import '../../../../fixture/entities/models_mock.dart';

class HTTPMock extends Mock implements HTTP {}

void main() {
  late final WeatherDatasource datasource;
  late final HTTP client;

  setUpAll(() {
    client = HTTPMock();
    datasource = WeatherRemoteDatasourceImpl(client: client);
  });

  group("WeatherRepositoryImpl Test", () {
    test("Get a current weather with success", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => client.get(
              path: "/data/2.5/weather",
              queryParams: {'lat': location.lat, 'lon': location.lon}))
          .thenAnswer((_) => Future.value(HttpStatus(success: (
                data: {
                  "weather": [ModelsMock.weather()]
                },
                statusCode: 201
              ))));
      final response = await datasource.getCurrentWeather(
          lat: location.lat, lon: location.lon);

      expect(response, equals(ModelsMock.weather()));
    });

    test("Get a current weather with an exception", () async {
      const location = (lat: 123.0, lon: 345.0);
      when(() => client.get(
              path: "/data/2.5/weather",
              queryParams: {'lat': location.lat, 'lon': location.lon}))
          .thenThrow(Exception("Don't have weather this location"));
      try {
        await datasource.getCurrentWeather(
            lat: location.lat, lon: location.lon);
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have weather this location");
      }
    });

    test("Get a list of cities by name with success", () async {
      const name = "London";
      when(() => client.get(
                path: "/geo/1.0/direct",
                queryParams: {'q': name, 'limit': 5},
              ))
          .thenAnswer((_) => Future.value(HttpStatus(
              success: (data: ModelsMock.citieMap(), statusCode: 201))));
      final response = await datasource.searchCity(name);

      expect(response, equals(ModelsMock.citieMap()));
    });

    test("Get a current weather with an exception", () async {
      const name = "London";
      when(() => client.get(
            path: "/geo/1.0/direct",
            queryParams: {'q': name, 'limit': 5},
          )).thenThrow(Exception("Don't have cities"));
      try {
        await datasource.searchCity(name);
      } catch (e) {
        expect(e, const TypeMatcher<Exception>());
        expect(e.toString(), "Exception: Don't have cities");
      }
    });
  });
}
