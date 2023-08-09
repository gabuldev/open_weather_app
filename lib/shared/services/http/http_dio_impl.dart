import 'package:dio/dio.dart' hide Response;
import 'package:open_weather_app/shared/services/http/http_status.dart';

import 'http.dart';

class HTTPDioImpl implements HTTP {
  final Dio dio;
  HTTPDioImpl({
    required this.dio,
  });

  @override
  Future<HttpStatus> get(
      {required String path, JSON? queryParams, JSON? headers}) async {
    try {
      final response = await dio.get(path,
          queryParameters: queryParams, options: Options(headers: headers));
      return HttpStatus(
          success: (data: response.data, statusCode: response.statusCode));
    } on DioException catch (e) {
      return HttpStatus(failure: (
        exception: e,
        errorData: e.response?.data,
        message: e.message,
        statusCode: e.response?.statusCode
      ));
    } catch (e) {
      return HttpStatus(failure: (
        exception: e,
        errorData: null,
        message: "Error internal on Application",
        statusCode: null
      ));
    }
  }

  @override
  Future<HttpStatus> post(
      {required String path,
      JSON? body,
      JSON? queryParams,
      JSON? headers}) async {
    try {
      final response = await dio.post(path,
          data: body,
          queryParameters: queryParams,
          options: Options(headers: headers));
      return HttpStatus(
          success: (data: response.data, statusCode: response.statusCode));
    } on DioException catch (e) {
      return HttpStatus(failure: (
        exception: e,
        errorData: e.response?.data,
        message: e.message,
        statusCode: e.response?.statusCode
      ));
    } catch (e) {
      return HttpStatus(failure: (
        exception: e,
        errorData: null,
        message: "Error internal on Application",
        statusCode: null
      ));
    }
  }

  @override
  Future<HttpStatus> delete({
    required String path,
    JSON? body,
    JSON? queryParams,
    JSON? headers,
  }) async {
    try {
      final response = await dio.delete(path,
          data: body,
          queryParameters: queryParams,
          options: Options(headers: headers));
      return HttpStatus(
          success: (data: response.data, statusCode: response.statusCode));
    } on DioException catch (e) {
      return HttpStatus(failure: (
        exception: e,
        errorData: e.response?.data,
        message: e.message,
        statusCode: e.response?.statusCode
      ));
    } catch (e) {
      return HttpStatus(failure: (
        exception: e,
        errorData: null,
        message: "Error internal on Application",
        statusCode: null
      ));
    }
  }

  @override
  Future<HttpStatus> put({
    required String path,
    JSON? body,
    JSON? queryParams,
    JSON? headers,
  }) async {
    try {
      final response = await dio.put(path,
          data: body,
          queryParameters: queryParams,
          options: Options(headers: headers));
      return HttpStatus(
          success: (data: response.data, statusCode: response.statusCode));
    } on DioException catch (e) {
      return HttpStatus(failure: (
        exception: e,
        errorData: e.response?.data,
        message: e.message,
        statusCode: e.response?.statusCode
      ));
    } catch (e) {
      return HttpStatus(failure: (
        exception: e,
        errorData: null,
        message: "Error internal on Application",
        statusCode: null
      ));
    }
  }
}
