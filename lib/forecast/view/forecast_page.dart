import 'package:blizzard/forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ForecastPage extends StatelessWidget {
  final int locationId;

  const ForecastPage({Key? key, required this.locationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            TodaysWeather(),
            const SizedBox(height: 32),
            ForecastResults()
          ],
        ),
      ),
    );
  }
}
