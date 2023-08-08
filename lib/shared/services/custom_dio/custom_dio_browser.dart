import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:open_weather_app/shared/services/utils/app_env.dart';

class CustomDioForBrowser extends DioForBrowser {
  CustomDioForBrowser() {
    options.baseUrl = AppEnv.baseURL;
    options.queryParameters = {"appid": AppEnv.appId};
  }
}

Dio getDioInstance() => CustomDioForBrowser();
