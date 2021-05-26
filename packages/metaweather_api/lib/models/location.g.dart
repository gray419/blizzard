// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    title: json['title'] as String?,
    locationType: json['locationType'] as String?,
    woeid: json['woeid'] as int?,
    lattLong: json['lattLong'] as String?,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'title': instance.title,
      'locationType': instance.locationType,
      'woeid': instance.woeid,
      'lattLong': instance.lattLong,
    };
