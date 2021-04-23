import 'models.dart';

class LocationResponse {
  List<Location>? locations;

  LocationResponse({this.locations});

  LocationResponse.fromJson(List<dynamic> json) {
    locations = json.map<Location>((e) => Location.fromJson(e)).toList();
  }
}
