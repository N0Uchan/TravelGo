import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';


class WeatherData {
  final double currentTemp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  final List<DailyForecast> dailyForecasts;

  WeatherData({
    required this.currentTemp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.dailyForecasts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final daily = json['daily'];

    List<DailyForecast> forecasts = [];
    for (int i = 0; i < (daily['time'] as List).length; i++) {
      forecasts.add(DailyForecast(
        date: DateTime.parse(daily['time'][i]),
        maxTemp: daily['temperature_2m_max'][i].toDouble(),
        minTemp: daily['temperature_2m_min'][i].toDouble(),
        weatherCode: daily['weather_code'][i],
      ));
    }

    return WeatherData(
      currentTemp: current['temperature_2m'].toDouble(),
      feelsLike: current['apparent_temperature'].toDouble(),
      humidity: current['relative_humidity_2m'].toInt(),
      windSpeed: current['wind_speed_10m'].toDouble(),
      weatherCode: current['weather_code'],
      dailyForecasts: forecasts,
    );
  }
}

class DailyForecast {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final int weatherCode;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCode,
  });
}

class WeatherCodeHelper {
  static IconData getWeatherIcon(int code) {
    switch (code) {
      case 0:
        return Icons.wb_sunny; // Clear sky
      case 1:
      case 2:
      case 3:
        return WeatherIcons.day_cloudy; // Partly cloudy
      case 45:
      case 48:
        return Icons.foggy; // Foggy
      case 51:
      case 53:
      case 55:
        return Icons.grain; // Drizzle
      case 61:
      case 63:
      case 65:
        return Icons.water_drop; // Rain
      case 66:
      case 67:
        return Icons.ac_unit; // Freezing Rain
      case 71:
      case 73:
      case 75:
        return WeatherIcons.snow; // Snow
      case 77:
        return Icons.snowing; // Snow grains
      case 80:
      case 81:
      case 82:
        return Icons.thunderstorm; // Rain showers
      case 85:
      case 86:
        return WeatherIcons.snowflake_cold; // Snow showers
      case 95:
        return Icons.flash_on; // Thunderstorm
      case 96:
      case 99:
        return Icons.flash_on; // Thunderstorm with hail
      default:
        return Icons.question_mark;
    }
  }

  static String getWeatherDescription(int code) {
    switch (code) {
      case 0:
        return "Clear sky";
      case 1:
        return "Mainly clear";
      case 2:
        return "Partly cloudy";
      case 3:
        return "Overcast";
      case 45:
      case 48:
        return "Foggy";
      case 51:
      case 53:
      case 55:
        return "Drizzle";
      case 61:
      case 63:
      case 65:
        return "Rain";
      case 66:
      case 67:
        return "Freezing Rain";
      case 71:
      case 73:
      case 75:
        return "Snow";
      case 77:
        return "Snow grains";
      case 80:
      case 81:
      case 82:
        return "Rain showers";
      case 85:
      case 86:
        return "Snow showers";
      case 95:
        return "Thunderstorm";
      case 96:
      case 99:
        return "Thunderstorm with hail";
      default:
        return "Unknown";
    }
  }

  static String getDayName(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dayAfterTomorrow = today.add(const Duration(days: 2));

    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return 'Today';
    } else if (date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day) {
      return 'Tomorrow';
    } else if (date.year == dayAfterTomorrow.year && date.month == dayAfterTomorrow.month && date.day == dayAfterTomorrow.day) {
      return 'Day after';
    } else {
      return _getWeekdayName(date.weekday);
    }
  }

  static String _getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}

class WeatherForecastWidget extends StatelessWidget {
  const WeatherForecastWidget({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCurrentWeather(context, weatherData),
            _buildWeatherDetails(context, weatherData),
            const Divider(height: 32),
            _buildDailyForecast(context, weatherData),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeather(BuildContext context, WeatherData weather) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  WeatherCodeHelper.getWeatherIcon(weather.weatherCode),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    WeatherCodeHelper.getWeatherDescription(weather.weatherCode),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${weather.currentTemp.toStringAsFixed(1)}°C',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(BuildContext context, WeatherData weather) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _WeatherDetail(
            icon: Icons.thermostat,
            label: 'Feels like',
            value: '${weather.feelsLike.toStringAsFixed(1)}°C',
          ),
          _WeatherDetail(
            icon: Icons.water_drop,
            label: 'Humidity',
            value: '${weather.humidity}%',
          ),
          _WeatherDetail(
            icon: Icons.air,
            label: 'Wind',
            value: '${weather.windSpeed} m/s',
          ),
        ],
      ),
    );
  }

  Widget _buildDailyForecast(BuildContext context, WeatherData weather) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weather.dailyForecasts.length,
        itemBuilder: (context, index) => SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: _DailyForecastCard(
            forecast: weather.dailyForecasts[index],
          ),
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withOpacity(0.8),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}

class _DailyForecastCard extends StatelessWidget {
  final DailyForecast forecast;

  const _DailyForecastCard({
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            WeatherCodeHelper.getDayName(forecast.date),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Icon(
            WeatherCodeHelper.getWeatherIcon(forecast.weatherCode),
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 32,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${forecast.minTemp.round()}°',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 12,
                ),
              ),
              Text(
                ' / ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 12,
                ),
              ),
              Text(
                '${forecast.maxTemp.round()}°',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            WeatherCodeHelper.getWeatherDescription(forecast.weatherCode),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}