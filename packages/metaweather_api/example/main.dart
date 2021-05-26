import 'dart:io';

import 'package:metaweather_api/metaweather_api.dart';

void main() async {
  final metaWeatherApiClient = MetaWeatherApiClient();

  try {
    final locations = await metaWeatherApiClient.searchForLocation('New York');
    print('${locations.first.title ?? 'no match'}');
    print('${locations.first.woeid ?? 'no match'}');
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}
