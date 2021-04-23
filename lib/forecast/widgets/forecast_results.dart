import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForecastResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => _ForecastResult(),
      ),
    );
  }
}

class _ForecastResult extends StatelessWidget {
  final day = 'Monday';
  final high = 70;
  final low = 55;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(day),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$high\u00b0'),
          SizedBox(
            width: 8,
          ),
          Text('$low\u00b0'),
        ],
      ),
    );
  }
}
