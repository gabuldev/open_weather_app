import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_app/shared/services/custom_dio/custom_dio_base.dart';

void main() {
  group("CustomDioBase test", () {
    test("Don't have any dio instance!", () {
      try {
        getDioInstance();
      } catch (e) {
        expect(e.toString(), equals("Exception: Don't have any dio instance!"));
      }
    });
  });
}
