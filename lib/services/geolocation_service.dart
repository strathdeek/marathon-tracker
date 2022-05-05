import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marathon_tracker/helpers/distance_helpers.dart';

class GeolocationService extends ChangeNotifier {
  StreamSubscription<Position>? positionStream;

  Position? currentPosition;

  GeolocationService();

  Future<void> determinePosition() async {
    var hasPermissions = await _checkAndRequestPermissions();

    if (hasPermissions) {
      var position = await Geolocator.getCurrentPosition();
      _onNewGpsPosition(position);
    }
  }

  void startLocationTracking() async {
    var hasPermissions = await _checkAndRequestPermissions();

    if (hasPermissions) {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );

      positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
        _onNewGpsPosition(position);
      });
    }
  }

  void stopLocationTracking() {
    positionStream?.cancel();
  }

  // returns true if the proper permissions have been granted, error otherwise
  Future<bool> _checkAndRequestPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return true;
  }

  void _onNewGpsPosition(Position? position) {
    if (position != null) {
      _updateCurrentPosition(position);
      notifyListeners();
    }
  }

  void _updateCurrentPosition(Position position) {
    currentPosition = position;
  }
}
