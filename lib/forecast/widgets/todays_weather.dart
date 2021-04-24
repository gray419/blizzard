import 'package:flutter/widgets.dart';
import 'package:weather_repository/weather_repository.dart';

class TodaysWeather extends StatelessWidget {
  final Forecast forecast;

  TodaysWeather({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = forecast.weather.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          forecast.locationName,
          style: TextStyle(fontSize: 24),
        ),
        Text(
          '${today.weatherState}',
          style: TextStyle(fontSize: 14),
        ),
        Text(
          '${today.temp.round()}\u00b0',
          style: TextStyle(fontSize: 60),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'H:${today.maxTemp.round()}\u00b0',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'L:${today.minTemp.round()}\u00b0',
              style: TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }
}
