import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_repository/weather_repository.dart';

class ForecastResults extends StatelessWidget {
  final Forecast forecast;

  const ForecastResults({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: forecast.weather.length - 1,
        itemBuilder: (context, index) => _ForecastResult(
          weather: forecast.weather[index + 1],
        ),
      ),
    );
  }
}

class _ForecastResult extends StatelessWidget {
  final Weather weather;

  const _ForecastResult({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
          'https://www.metaweather.com/static/img/weather/png/${weather.weatherStateAbbr}.png'),
      title: Text(DateFormat('EEEE').format(weather.date)),
      subtitle: Text(weather.weatherState),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${weather.maxTemp}\u00b0',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            '${weather.minTemp}\u00b0',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
