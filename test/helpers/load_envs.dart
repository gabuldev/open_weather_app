import 'package:open_weather_app/shared/services/utils/app_env.dart';

loadEnvs() {
  AppEnv.init(
    baseURL: "https://jsonplaceholder.typicode.com",
    appId: "myappId",
  );
}
