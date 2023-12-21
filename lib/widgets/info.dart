import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InfoBarItem(),
        InfoBarItem(),
        InfoBarItem(),
      ],
    );
  }
}

class InfoBarItem extends StatelessWidget {
  const InfoBarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.14,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.wind_power_rounded,
              color: Colors.white,
            ),
            Text(
              "Wind",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              "5-8 km/hr",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
