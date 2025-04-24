import 'package:geolocator/geolocator.dart';

class Location {
  late var latitude;
  late var longitude;

  Future<void> getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch(e) {
      print(e);
    }
  }
}