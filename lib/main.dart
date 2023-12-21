import 'package:flutter/material.dart';
import 'package:weather_forecast_app/screens/home.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: HomeScreen(),
    ),
  ));
}
