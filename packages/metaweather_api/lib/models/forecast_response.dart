import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'forecast_response.g.dart';

@JsonSerializable()
class ForecastResponse {
  String? title;
  int? woeid;
  @JsonKey(name: "consolidated_weather")
  List<ConsolidatedWeather>? consolidatedWeather;

  ForecastResponse({this.title, this.woeid, this.consolidatedWeather});

  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastResponseToJson(this);
}
