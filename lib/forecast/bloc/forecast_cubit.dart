import 'package:blizzard/extensions/double_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final WeatherRepository _weatherRepository;

  ForecastCubit(this._weatherRepository) : super(ForecastState.initial());

  Future<void> fetchForecast(int locationId) async {
    emit(ForecastState.loading());
    try {
      final forecast = await _weatherRepository.forecastForLocation(locationId);
      emit(ForecastState.success(forecast));
    } catch (e) {
      emit(ForecastState.failure());
    }
  }

  Future<void> switchUnits() async {
    final isCelsius = !state.isCelsius;
    var convertedWeatherUnits = <Weather>[];
    state.forecast.weather.forEach(
      (element) {
        convertedWeatherUnits.add(
          element.copyWith(
            temp: isCelsius
                ? element.temp.toCelsius()
                : element.temp.toFahrenheit(),
            maxTemp: isCelsius
                ? element.maxTemp.toCelsius()
                : element.maxTemp.toFahrenheit(),
            minTemp: isCelsius
                ? element.minTemp.toCelsius()
                : element.minTemp.toFahrenheit(),
          ),
        );
      },
    );
    emit(
      state.copyWith(
        isCelsius: isCelsius,
        forecast: Forecast(state.forecast.locationName, convertedWeatherUnits),
      ),
    );
  }
}
