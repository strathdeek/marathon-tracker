import 'package:flutter/material.dart';
import 'package:marathon_tracker/views/gpsTest.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: GpsTest()),
    );
  }
}
