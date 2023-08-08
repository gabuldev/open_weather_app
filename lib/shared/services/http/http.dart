import 'package:open_weather_app/shared/services/http/http_status.dart';

abstract class HTTP {
  Future<HttpStatus> get({
    required String path,
    JSON? queryParams,
    JSON? headers,
  });
  Future<HttpStatus> post({
    required String path,
    JSON? body,
    JSON? queryParams,
    JSON? headers,
  });
  Future<HttpStatus> put({
    required String path,
    JSON? body,
    JSON? queryParams,
    JSON? headers,
  });
  Future<HttpStatus> delete({
    required String path,
    JSON? body,
    JSON? queryParams,
    JSON? headers,
  });
}
