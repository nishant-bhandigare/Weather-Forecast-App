import 'package:flutter/material.dart';
import 'package:weather_forecast_app/widgets/display.dart';
import 'package:weather_forecast_app/widgets/info.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              DisplayWidget(),
              InfoBar(),
            ],
          ),
        ),
      ),
    );
  }

}