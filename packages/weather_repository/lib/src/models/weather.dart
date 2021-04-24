import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final DateTime date;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherState;
  final String weatherStateAbbr;

  Weather copyWith({
    DateTime? date,
    double? temp,
    double? maxTemp,
    double? minTemp,
    String? weatherState,
    String? weatherStateAbbr,
  }) {
    return Weather(
        date ?? this.date,
        temp ?? this.temp,
        maxTemp ?? this.maxTemp,
        minTemp ?? this.minTemp,
        weatherState ?? this.weatherState,
        weatherStateAbbr ?? this.weatherStateAbbr);
  }

  Weather(this.date, this.temp, this.maxTemp, this.minTemp, this.weatherState,
      this.weatherStateAbbr);

  @override
  List<Object?> get props =>
      [date, temp, maxTemp, minTemp, weatherState, weatherStateAbbr];
}
