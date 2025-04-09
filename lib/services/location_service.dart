import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<String> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return 'Unknown';

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return 'Permission denied';
      }
    }

    Position pos = await Geolocator.getCurrentPosition();
    return '${pos.latitude},${pos.longitude}';
  }
}
