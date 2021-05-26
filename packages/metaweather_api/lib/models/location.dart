import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  String? title;
  String? locationType;
  int? woeid;
  String? lattLong;

  Location({this.title, this.locationType, this.woeid, this.lattLong});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
