import 'dart:convert';

import 'package:http/http.dart';

import '../models/models.dart';
import 'weather_service.dart';

class MetaWeatherApiClient extends WeatherService {
  final _httpClient = Client();
  final _baseUrl = 'www.metaweather.com';

  @override
  Future<LocationResponse> searchForLocation(String term) async {
    final queryParams = <String, String>{'query': term};
    final url = Uri.https(_baseUrl, '/api/location/search', queryParams);

    final response = await _httpClient.get(url);
    final List<dynamic> body = jsonDecode(response.body);

    return LocationResponse.fromJson(body);
  }

  @override
  Future<ForecastResponse> forecastForLocation(int locationId) async {
    final url = Uri.https(_baseUrl, '/api/location/$locationId');

    final response = await _httpClient.get(url);
    final body = jsonDecode(response.body);

    return ForecastResponse.fromJson(body);
  }
}
