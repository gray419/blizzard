import 'package:blizzard/forecast/view/forecast_page.dart';
import 'package:blizzard/search/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blizzard'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            SearchBar(
              onChanged: (city) => print('$city'),
            ),
            const SizedBox(height: 16),
            SearchResults(
              onTap: (city) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ForecastPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
