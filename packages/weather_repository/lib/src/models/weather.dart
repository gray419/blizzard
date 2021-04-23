class Weather {
  final DateTime date;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherState;
  final String weatherStateAbbr;

  Weather(this.date, this.temp, this.maxTemp, this.minTemp, this.weatherState,
      this.weatherStateAbbr);
}
