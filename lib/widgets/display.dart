import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget{
  DisplayWidget({super.key});

  var date = 25;
  var month = "January";
  var day = "Wednesday";
  var temp = -10;
  var realFeel = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.55,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$date $month, $day", style: TextStyle(color: Colors.white, fontSize: 18),),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.1,
          ),
          Row(
            children: [
              Spacer(),
              Text("$temp °C", style: TextStyle(color: Colors.white, fontSize: 70, fontWeight: FontWeight.w900),),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Text("Real feel $realFeel °C", style: TextStyle(color: Colors.white, fontSize: 12),),
            ],
          ),
        ],
      ),
    );
  }

}