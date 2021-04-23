import 'package:flutter/widgets.dart';

class TodaysWeather extends StatelessWidget {
  final city = 'New York';
  final currentTemperature = 61;
  final daysHigh = 63;
  final daysLow = 37;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          city,
          style: TextStyle(fontSize: 24),
        ),
        Text(
          '$currentTemperature\u00b0',
          style: TextStyle(fontSize: 40),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'H:$daysHigh\u00b0',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'L:$daysLow\u00b0',
              style: TextStyle(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
