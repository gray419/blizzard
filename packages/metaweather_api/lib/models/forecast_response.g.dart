// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastResponse _$ForecastResponseFromJson(Map<String, dynamic> json) {
  return ForecastResponse(
    title: json['title'] as String?,
    woeid: json['woeid'] as int?,
    consolidatedWeather: (json['consolidated_weather'] as List<dynamic>?)
        ?.map((e) => ConsolidatedWeather.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ForecastResponseToJson(ForecastResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'woeid': instance.woeid,
      'consolidated_weather': instance.consolidatedWeather,
    };
