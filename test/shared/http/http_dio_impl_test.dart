import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_app/shared/services/custom_dio/custom_dio.dart';
import 'package:open_weather_app/shared/services/http/http_dio_impl.dart';
import 'package:open_weather_app/shared/services/http/http_status.dart';

import '../../helpers/load_envs.dart';

void main() {
  loadEnvs();
  late final Dio dio;
  late final HTTPDioImpl http;

  setUpAll(() {
    dio = getDioInstance();
    http = HTTPDioImpl(dio: dio);
  });

  group("HTTPDioImpl Test", () {
    test("Method - GET call API with success", () async {
      final req = await http.get(path: "/posts");
      expect(req.response, isNotNull);
      expect(req.response?.data, const TypeMatcher<List<dynamic>>());
      expect(req.response?.statusCode, equals(200));
      expect(req.failure, isNull);
    });

    test("Method - GET call API with failure", () async {
      final req = await http.get(path: "/postss");
      expect(req.response, isNull);
      expect(req.failure?.statusCode, equals(404));
      expect(req.failure, isNotNull);
    });

    test("Method - POST call API with success", () async {
      final post = {"name": "John", "id": "123"};
      final req = await http.post(
        path: "/posts",
        body: post,
      );
      expect(req.response, isNotNull);
      expect(req.response?.data, const TypeMatcher<JSON>());
      expect(req.response?.statusCode, equals(201));
      expect(req.failure, isNull);
    });

    test("Method - POST call API with failure", () async {
      final post = {"name": "John", "id": "123"};
      final req = await http.post(
        path: "/postss",
        body: post,
      );
      expect(req.response, isNull);
      expect(req.failure?.statusCode, equals(404));
      expect(req.failure, isNotNull);
    });

    test("Method - PUT call API with success", () async {
      final post = {"name": "John", "id": "123"};
      final req = await http.put(
        path: "/posts/1",
        body: post,
      );
      expect(req.response, isNotNull);
      expect(req.response?.data, const TypeMatcher<JSON>());
      expect(req.response?.statusCode, equals(200));
      expect(req.failure, isNull);
    });

    test("Method - PUT call API with failure", () async {
      final post = {"name": "John", "id": "123"};
      final req = await http.put(
        path: "/postss",
        body: post,
      );
      expect(req.response, isNull);
      expect(req.failure?.statusCode, equals(404));
      expect(req.failure, isNotNull);
    });

    test("Method - DELETE call API with success", () async {
      final post = {"name": "John", "id": "123"};
      final req = await http.delete(
        path: "/posts/1",
        body: post,
      );
      expect(req.response, isNotNull);
      expect(req.response?.data, const TypeMatcher<JSON>());
      expect(req.response?.statusCode, equals(200));
      expect(req.failure, isNull);
    });

    test("Method - DELETE call API with failure", () async {
      final post = {"name": "John", "id": "123"};
      final req = await http.delete(
        path: "/postss",
        body: post,
      );
      expect(req.response, isNull);
      expect(req.failure?.statusCode, equals(404));
      expect(req.failure, isNotNull);
    });
  });
}
