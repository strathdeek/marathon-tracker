import 'package:flutter/material.dart';
import 'package:marathon_tracker/views/gps_test.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: GpsTest()),
    );
  }
}
