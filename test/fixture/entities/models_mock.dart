import 'package:open_weather_app/shared/services/http/http_status.dart';

class ModelsMock {
  static Map<String, dynamic> weather() => {
        'id': 501,
        'main': "Rain",
        'description': "moderate rain",
        'icon': "10d",
      };

  static List<String> cities() => [
        '''{
          "name": "London",
          "lat": 37.1289771,
          "lon": -84.0832646,
          "country": "US",
          "state": "Kentucky"
        }'''
      ];

  static List<JSON> citieMap() => [
        {
          "name": "London",
          "lat": 37.1289771,
          "lon": -84.0832646,
          "country": "US",
          "state": "Kentucky"
        }
      ];
}
