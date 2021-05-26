import 'dart:convert';

import 'package:http/http.dart';

import '../models/models.dart';
import 'weather_service.dart';

class SearchForLocationException implements Exception {}

class ForecastForLocationException implements Exception {}

class MetaWeatherApiClient extends WeatherService {
  final _httpClient = Client();
  final _baseUrl = 'www.metaweather.com';

  @override
  Future<List<Location>> searchForLocation(String term) async {
    final queryParams = <String, String>{'query': term};
    final url = Uri.https(_baseUrl, '/api/location/search', queryParams);

    final response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw SearchForLocationException();
    }
    final List<dynamic> body = jsonDecode(response.body);

    final locations = <Location>[];

    body.forEach((element) {
      final location = Location.fromJson(element);
      locations.add(location);
    });

    return locations;
  }

  @override
  Future<ForecastResponse> forecastForLocation(int locationId) async {
    final url = Uri.https(_baseUrl, '/api/location/$locationId');

    final response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw ForecastForLocationException();
    }
    final body = jsonDecode(response.body);

    return ForecastResponse.fromJson(body);
  }
}
