import 'package:geolocator/geolocator.dart';
import 'package:open_weather_app/modules/weather/infra/drivers/weather_driver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherLocalDriverImpl implements WeatherDriver {
  @override
  Future<({double lat, double lon})> currentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final response = await Geolocator.getCurrentPosition();
    return (lat: response.latitude, lon: response.longitude);
  }

  @override
  Future<List<String>> getCities() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getStringList("cities") ?? [];
  }

  @override
  Future<bool> saveCities(List<String> cities) async {
    final instance = await SharedPreferences.getInstance();
    instance.setStringList("cities", cities);
    return true;
  }
}
