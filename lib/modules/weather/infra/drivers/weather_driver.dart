abstract class WeatherDriver {
  Future<({double lat, double lon})> currentLocation();

  Future<bool> saveCities(List<String> cities);

  Future<List<String>> getCities();
}
