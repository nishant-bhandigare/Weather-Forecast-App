import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_forecast_app/backend/api_key.dart';
import 'package:weather_forecast_app/widgets/display.dart';
import 'package:weather_forecast_app/widgets/info.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? _currentAddress;
  Position? _currentPosition;
  // double lat = 19.378808;
  // double long = 72.824551;
  double lat = 0.0;
  double long = 0.0;
  String key = api_key;
  String cityName = 'Kongens Lyngby';

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      // print('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        // print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      // print(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        lat = position.latitude;
        long = position.longitude;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }


  // Future<void> getWeather(double latitude, double longitude) async {
  //   final String apiKey = key;
  //   WeatherFactory wf = WeatherFactory(apiKey);
  //
  //   try {
  //     Weather? weather = await wf.currentWeatherByLocation(latitude, longitude);
  //
  //     if (weather != null) {
  //       // print('Location: ${weather.areaName}');
  //       if (weather.temperature != null) {
  //         // print('Temperature: ${weather.temperature!.celsius}°C');
  //       } else {
  //         // print('Temperature not available');
  //       }
  //       // print('Weather: ${weather.weatherDescription}');
  //       // print('Weather: ${weather.weatherDescription}');
  //       // print('Humidity: ${weather.humidity}%');
  //       // print('Wind Speed: ${weather.windSpeed} m/s');
  //       // print('Pressure: ${weather.pressure} hPa');
  //       // print('Sunrise: ${weather.sunrise}');
  //       // print('Sunset: ${weather.sunset}');
  //       print(weather);
  //     } else {
  //       print('Weather data not available');
  //     }
  //   } catch (e) {
  //     print('Error fetching weather: $e');
  //   }
  // }

  Future<void> getWeather(double latitude, double longitude) async {
    final String apiKey = key; // Replace with your actual API key
    WeatherFactory wf = WeatherFactory(apiKey);

    try {
      Weather? weather = await wf.currentWeatherByLocation(latitude, longitude);

      if (weather != null) {
        print('Place Name: ${weather.areaName}');
        print('Date: ${weather.date}');
        print('Weather: ${weather.weatherDescription}');
        print('Temperature: ${weather.temperature?.celsius}°C');
        print('Temp (min): ${weather.tempMin?.celsius}°C');
        print('Temp (max): ${weather.tempMax?.celsius}°C');
        // print('Temp (feels like): ${weather.feelsLike?.celsius}°C');
        print('Sunrise: ${weather.sunrise}');
        print('Sunset: ${weather.sunset}');
        print('Weather Condition code: ${weather.weatherConditionCode}');
      } else {
        print('Weather data not available');
      }
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }



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
              // Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              // Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text('LAT: ${lat}'),
              Text('LNG: ${long}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: (){
                  _getCurrentPosition();
                  getWeather(lat, long);
                },
                child: const Text("Get Current Location"),
              )
            ],
          ),
        ),
      ),
    );
  }
}