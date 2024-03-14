import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:weather_app/models/weather_models.dart";
import "package:weather_app/services/weather_service.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService("6f5c026c15ef4110ea6503a1b0f5ea51");
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/sunny.json";

    switch (mainCondition) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloud.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rain.json";
      case "thunderstorm":
        return "assets/thunderstorm.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  Color _getGradientColor(String? condition, bool isStart) {
    if (condition == null) {
      return isStart ? Colors.blue.shade200 : Colors.blue.shade600;
    }

    switch (condition) {
      case "clear":
        return isStart ? Colors.orange.shade300 : Colors.orange.shade700;
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return isStart ? Colors.grey.shade300 : Colors.grey.shade600;
      case "rain":
      case "drizzle":
      case "shower rain":
        return isStart ? Colors.blue.shade300 : Colors.blue.shade600;
      case "thunderstorm":
        return isStart ? Colors.grey.shade800 : Colors.grey.shade900;
      default:
        return isStart ? Colors.blue.shade200 : Colors.blue.shade600;
    }
  }

  @override
  void initState() {
    super.initState();

    // fetch the weather
    _fetchWeather();
  }

  // weather animations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _getGradientColor(_weather?.mainCondition, true),
              _getGradientColor(_weather?.mainCondition, false),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _weather?.cityName ?? "Loading city...",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Lottie.asset(
                    getWeatherAnimation(_weather?.mainCondition),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "${_weather?.temperature.round()}°C",
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _weather?.mainCondition?.toUpperCase() ?? "",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
