import 'package:flutter/material.dart';
import 'package:marathon_tracker/services/geolocation.dart';
import 'package:provider/provider.dart';

class GpsTest extends StatelessWidget {
  const GpsTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "current location",
        ),
        Consumer<GeolocationService>(
            builder: ((context, value, child) => Column(
                  children: [
                    Text(value.longitude),
                    Text(value.lattitude),
                  ],
                ))),
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
                onPressed: () => context.read<GeolocationService>().startLocationTrackingAsync(),
                child: const Text("Track")),
            ElevatedButton(
                onPressed: () => context.read<GeolocationService>().stopLocationTracking(), child: const Text("Stop")),
          ],
        ),
      ],
    );
  }
}
