import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

// returns the distance (in Meters) between two points
double getDistance(Position pos1, Position pos2) {
  // Todo: implement distance calculation between GPS coords
  return 50;
}

// takes speed in M/S and returns pace in Min/Km
double speedToPace(double speed) {
  return 1 / (speed * 60 / 1000);
}
