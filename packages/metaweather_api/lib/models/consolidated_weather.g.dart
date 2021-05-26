// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consolidated_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsolidatedWeather _$ConsolidatedWeatherFromJson(Map<String, dynamic> json) {
  return ConsolidatedWeather(
    id: json['id'] as int?,
    weatherStateName: json['weather_state_name'] as String?,
    weatherStateAbbr: json['weather_state_abbr'] as String?,
    applicableDate: json['applicable_date'] as String?,
    minTemp: (json['min_temp'] as num?)?.toDouble(),
    maxTemp: (json['max_temp'] as num?)?.toDouble(),
    theTemp: (json['the_temp'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$ConsolidatedWeatherToJson(
        ConsolidatedWeather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weather_state_name': instance.weatherStateName,
      'weather_state_abbr': instance.weatherStateAbbr,
      'applicable_date': instance.applicableDate,
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'the_temp': instance.theTemp,
    };
