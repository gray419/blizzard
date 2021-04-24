class Weather {
  final DateTime date;
  final int temp;
  final int maxTemp;
  final int minTemp;
  final String weatherState;
  final String weatherStateAbbr;

  Weather(this.date, this.temp, this.maxTemp, this.minTemp, this.weatherState,
      this.weatherStateAbbr);
}
