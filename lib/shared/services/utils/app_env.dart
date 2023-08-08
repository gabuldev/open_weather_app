class AppEnv {
  static late final String _baseURL;
  static String get baseURL => _baseURL;
  static late final String _appId;
  static String get appId => _appId;

  static void init({required String baseURL, required String appId}) {
    _baseURL = baseURL;
    _appId = appId;
  }
}
