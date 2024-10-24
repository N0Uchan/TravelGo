import 'package:flutter/material.dart';
import 'package:travel_go/util/fetch_weather.dart';
import 'package:travel_go/widgets/weather_forecast_widget.dart';

class WeatherLoader extends StatefulWidget {
  const WeatherLoader({super.key, required this.queryPlace});
  final String queryPlace;

  @override
  State<WeatherLoader> createState() {
    return _WeatherLoaderState();
  }
}

class _WeatherLoaderState extends State<WeatherLoader> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherData?>(
      future: fetchWeatherData(widget.queryPlace),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 200,
            width: 250,
            child: Image.asset(
              'assets/gifs/weather_loading.gif',
              fit: BoxFit.scaleDown,
            ),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            height: 200,
            width: 250,
            child: Image.asset(
              'assets/gifs/weather_loading.gif',
              width: 50,
              height: 50,
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('No weather data available'),
          );
        }
        return WeatherForecastWidget(weatherData: snapshot.data!);
      },
    );
  }
}
