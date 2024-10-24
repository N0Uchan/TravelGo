import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:travel_go/widgets/weather_forecast_widget.dart';

Future<WeatherData?> fetchWeatherData(String queryPlace) async {
  if (queryPlace.trim().isEmpty) {
    throw Exception('Please enter a location name');
  }

  final queryPlaceName = queryPlace.replaceAll(" ", "%");
  final geoCodingUrl = Uri.parse(
      'https://api.geoapify.com/v1/geocode/search?text=$queryPlaceName&apiKey=e696da94999747508e7a031760c921c6');
  
  try {
    final response = await http.get(geoCodingUrl);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['features'] is List && data['features'].isNotEmpty) {
        final feature = data['features'][0];
        final lon = feature['geometry']['coordinates'][0];
        final lat = feature['geometry']['coordinates'][1];
        
        final weatherUrl = Uri.parse(
            'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,cloud_cover,relative_humidity_2m,apparent_temperature,weather_code,pressure_msl,surface_pressure,wind_speed_10m,wind_direction_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset&forecast_days=3&wind_speed_unit=ms&timezone=auto');
        
        final weatherResponse = await http.get(weatherUrl);
        if (weatherResponse.statusCode == 200) {
          return WeatherData.fromJson(jsonDecode(weatherResponse.body));
        } else {
          throw Exception('Failed to fetch weather data: ${weatherResponse.statusCode}');
        }
      } else {
        throw Exception('No results found for the provided address');
      }
    } else {
      throw Exception('Error fetching geocode data: ${response.statusCode}');
    }
  } catch (error) {
    if (error is SocketException) {
      throw Exception('No internet connection available');
    }
    throw Exception('Error: $error');
  }
}