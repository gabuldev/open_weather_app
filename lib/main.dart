import 'package:flutter/material.dart';
import 'package:open_weather_app/app/app_widget.dart';
import 'package:open_weather_app/shared/services/utils/app_env.dart';

void main() {
  const baseURL = String.fromEnvironment("BASE_URL");
  const appId = String.fromEnvironment("APPID");
  AppEnv.init(baseURL: baseURL, appId: appId);
  runApp(const AppWidget());
}
