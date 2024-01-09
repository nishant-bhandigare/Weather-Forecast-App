import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_forecast_app/backend/api_key.dart';
import 'package:weather_forecast_app/widgets/display.dart';
import 'package:weather_forecast_app/widgets/info.dart';
import 'package:weather_forecast_app/widgets/sunrise_sunset.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
    void initState() {
      super.initState();
      _getCurrentPosition();
    }

  String? _currentAddress;
  Position? _currentPosition;
  double lat = 0.0;
  double long = 0.0;
  String key = api_key;

  Weather? _weather;
  List<Weather>? _forecast;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
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
        getWeather(lat, long);
        getDailyForecast(lat, long);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getWeather(double latitude, double longitude) async {
    const String apiKey = api_key;
    WeatherFactory wf = WeatherFactory(apiKey);

    try {
      final weather = await wf.currentWeatherByLocation(latitude, longitude);
      setState(() {
        _weather = weather;
      });

      if (weather != null) {
        print("Date ${_weather?.date?.day}");
        print("Cloudiness ${_weather?.cloudiness}");
        print("Humidity ${_weather?.humidity}");
        print("Pressure ${_weather?.pressure}");
        print("Sunrise ${_weather?.sunrise}");
        print("Sunset ${_weather?.sunset}");
        print("Weather Description ${_weather?.weatherDescription}");
        print("Weather Icon ${_weather?.weatherIcon}");


      } else {
        print('Weather data not available');
      }
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  Future<void> getDailyForecast(double latitude, double longitude) async {
    final String apiKey = api_key;
    WeatherFactory wf = WeatherFactory(apiKey);

    try {
      final forecast = await wf.fiveDayForecastByLocation(latitude, longitude);
      if (forecast != null && forecast.isNotEmpty) {
        setState(() {
          _forecast = forecast;
        });
      } else {
        print('Forecast data not available');
      }
    } catch (e) {
      print('Error fetching forecast: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(34, 42, 54, 1),
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              DisplayWidget(
                  temp: _weather?.temperature?.celsius?.toInt() ?? 0,
                  realFeel: _weather?.tempFeelsLike?.celsius?.toInt() ?? 0),
              InfoBar(weather: _weather),
              SunriseSunset(weather: _weather,),
              // ElevatedButton(
              //   onPressed: () {
              //     _getCurrentPosition();
              //   },
              //   child: const Text("Update"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}