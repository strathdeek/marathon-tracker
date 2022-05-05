import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:marathon_tracker/services/geolocation_service.dart';
import 'package:provider/provider.dart';

class GpsTest extends StatefulWidget {
  const GpsTest({Key? key}) : super(key: key);

  @override
  State<GpsTest> createState() => _GpsTestState();
}

class _GpsTestState extends State<GpsTest> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<GeolocationService>(builder: ((context, value, child) {
          return Column(
            children: [
              SizedBox(
                height: 400,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(value.latitude, value.longitude),
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return const Text("© OpenStreetMap contributors");
                      },
                    ),
                  ],
                ),
              ),
              const Text(
                "current location",
              ),
              Text(value.latitude.toString()),
              Text(value.longitude.toString()),
            ],
          );
        })),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () => context.read<GeolocationService>().determinePosition(),
                child: const Text("Ping Location")),
            ElevatedButton(
                onPressed: () => context.read<GeolocationService>().startLocationTracking(),
                child: const Text("Track")),
            ElevatedButton(
                onPressed: () => context.read<GeolocationService>().stopLocationTracking(), child: const Text("Stop")),
          ],
        ),
        ElevatedButton(
            onPressed: () => _mapController.move(
                LatLng(context.read<GeolocationService>().latitude, context.read<GeolocationService>().longitude), 13),
            child: const Text("Update Map"))
      ],
    );
  }
}
