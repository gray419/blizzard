import 'package:json_annotation/json_annotation.dart';

part 'consolidated_weather.g.dart';

@JsonSerializable()
class ConsolidatedWeather {
  int? id;
  @JsonKey(name: "weather_state_name")
  String? weatherStateName;
  @JsonKey(name: "weather_state_abbr")
  String? weatherStateAbbr;
  @JsonKey(name: "applicable_date")
  String? applicableDate;
  @JsonKey(name: "min_temp")
  double? minTemp;
  @JsonKey(name: "max_temp")
  double? maxTemp;
  @JsonKey(name: "the_temp")
  double? theTemp;

  ConsolidatedWeather(
      {this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.applicableDate,
      this.minTemp,
      this.maxTemp,
      this.theTemp});

  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      _$ConsolidatedWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$ConsolidatedWeatherToJson(this);
}
