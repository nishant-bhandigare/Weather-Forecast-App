import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class InfoBar extends StatelessWidget {
  InfoBar({super.key, required this.weather});
  Weather? weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InfoBarItem(
                icon: Icons.wb_cloudy_rounded,
                label: "Weather",
                data: "${weather?.weatherDescription}" ?? "N/A"),
            InfoBarItem(
                icon: Icons.wind_power_rounded,
                label: "Wind",
                data: "${weather?.windSpeed.toString()} km/hr" ?? "0.0 km/hr"),
            InfoBarItem(
                icon: Icons.thermostat_rounded,
                label: "Min ~ Max",
                data:
                    "${weather?.tempMin?.celsius?.toInt()} ~ ${weather?.tempMax?.celsius?.toInt()} °C" ??
                        "0 ~ 0 °C"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InfoBarItem(
                icon: Icons.wb_cloudy_rounded,
                label: "Cloudiness",
                data: "${weather?.cloudiness} %" ?? "0.0 %"),
            InfoBarItem(
                icon: Icons.water_drop_outlined,
                label: "Humidity",
                data: "${weather?.humidity.toString()} %" ?? "0.0 %"),
            InfoBarItem(
                icon: Icons.thermostat_rounded,
                label: "Pressure",
                data: "${weather?.pressure?.toInt()} hPa" ?? "0.0 hPa"),
          ],
        ),
      ],
    );
  }
}

class InfoBarItem extends StatefulWidget {
  InfoBarItem(
      {super.key, required this.icon, required this.label, required this.data});

  IconData icon;
  String label;
  String data;

  @override
  State<InfoBarItem> createState() => _InfoBarItemState();
}

class _InfoBarItemState extends State<InfoBarItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.14,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              // CupertinoColors.systemPurple,
              // Color.fromRGBO(60, 244, 250, 1),
              Color.fromRGBO(208, 104, 252, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              widget.icon,
              color: Colors.white,
            ),
            Text(
              widget.label,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              widget.data,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
