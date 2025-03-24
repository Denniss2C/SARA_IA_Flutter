import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  double? latitude;
  double? longitude;

  void updateLocation(double lat, double lon) {
    latitude = lat;
    longitude = lon;
    notifyListeners();
  }

  Future<void> fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      notifyListeners();
    } catch (e) {
      print("Error obteniendo ubicación: $e");
    }
  }
}
