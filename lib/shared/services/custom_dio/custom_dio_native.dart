import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../utils/app_env.dart';

class CustomDioForNative extends DioForNative {
  CustomDioForNative() {
    options.baseUrl = AppEnv.baseURL;
    options.queryParameters = {"appid": AppEnv.appId};
  }
}

Dio getDioInstance() => CustomDioForNative();
