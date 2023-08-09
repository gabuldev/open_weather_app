import 'package:open_weather_app/modules/weather/infra/datasources/weather_datasource.dart';
import 'package:open_weather_app/shared/services/http/http.dart';
import 'package:open_weather_app/shared/services/http/http_status.dart';

class WeatherRemoteDatasourceImpl implements WeatherDatasource {
  final HTTP client;
  WeatherRemoteDatasourceImpl({
    required this.client,
  });
  @override
  Future<JSON> getCurrentWeather(
      {required double lat, required double lon}) async {
    final response = await client
        .get(path: "/data/2.5/weather", queryParams: {'lat': lat, 'lon': lon});

    if (response.failure != null) {
      throw Exception(response.failure!.message);
    }

    return (response.success!.data! as JSON)['weather'][0];
  }

  @override
  Future<List<JSON>> searchCity(String name) async {
    final response = await client.get(
      path: "/geo/1.0/direct",
      queryParams: {'q': name, 'limit': 5},
    );

    if (response.failure != null) {
      throw Exception(response.failure!.message);
    }

    return List.from(response.success!.data as List);
  }
}
