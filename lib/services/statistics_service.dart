import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marathon_tracker/services/geolocation_service.dart';

import '../helpers/distance_helpers.dart';

class StatisticsService extends ChangeNotifier {
  final GeolocationService _geolocationService;

  List<Position> route = List.empty();

  // total distance travelled (in Meters)
  double distanceTravelled = 0.0;

  // current pace (in Min/KM)
  double currentPace = 0.0;

  StatisticsService(GeolocationService geolocationService) : _geolocationService = geolocationService {
    _geolocationService.addListener(_onNewPositionReceived);
  }

  void _onNewPositionReceived() {
    if (_geolocationService.currentPosition != null) {
      route.add(_geolocationService.currentPosition!);
      _updateCurrentDistance();
      notifyListeners();
    }
  }

  void _updateCurrentDistance() {
    var totalTravelled = 0.0;
    for (var i = 0; i < route.length - 1; i++) {
      totalTravelled += getDistance(route[i], route[i + 1]);
    }
    distanceTravelled = totalTravelled;
  }

  void _updateCurrentPace() {}
}
