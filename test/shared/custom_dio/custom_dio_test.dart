import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_app/shared/services/custom_dio/custom_dio.dart';

import '../../helpers/load_envs.dart';

void main() {
  loadEnvs();

  group("CustomDio test", () {
    test("Get a instance of Dio", () {
      final instance = getDioInstance();
      expect(instance, const TypeMatcher<Dio>());
    });
  });
}
