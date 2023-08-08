import 'package:open_weather_app/shared/services/utils/app_env.dart';
import 'package:test/test.dart';

import '../../helpers/load_envs.dart';

void main() {
  loadEnvs();
  group('AppEnv Test', () {
    test("Recovery baseURL and appId with success", () {
      expect(AppEnv.baseURL, equals("https://jsonplaceholder.typicode.com"));
      expect(AppEnv.appId, equals("myappId"));
    });
  });
}
