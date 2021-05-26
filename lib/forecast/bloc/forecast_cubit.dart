import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final WeatherRepository _weatherRepository;

  ForecastCubit(this._weatherRepository) : super(ForecastState.initial());

  Future<void> fetchForecast(int locationId) async {
    emit(ForecastState.loading(state.isCelsius));
    try {
      final forecast =
          await _weatherRepository.forecastForLocation(locationId: locationId);
      emit(ForecastState.success(forecast, state.isCelsius));
    } catch (e) {
      emit(ForecastState.failure());
    }
  }

  Future<void> refreshForecast(int locationId) async {
    emit(ForecastState.loading(state.isCelsius));
    try {
      final forecast =
          await _weatherRepository.forecastForLocation(locationId: locationId);
      final weather = state.isCelsius
          ? forecast.weather
          : _weatherRepository.convertTemperature(
              forecast.weather, state.isCelsius);
      emit(
        ForecastState._(
          status: ForecastStatus.success,
          isCelsius: state.isCelsius,
          forecast: Forecast(
              locationName: forecast.locationName,
              weather: weather,
              locationId: forecast.locationId),
        ),
      );
    } catch (e) {
      emit(ForecastState.failure());
    }
  }

  Future<void> switchUnits() async {
    final isCelsius = !state.isCelsius;
    final convertedWeatherUnits = _weatherRepository.convertTemperature(
        state.forecast.weather, isCelsius);
    emit(
      state.copyWith(
        isCelsius: isCelsius,
        forecast: Forecast(
          locationName: state.forecast.locationName,
          locationId: state.forecast.locationId,
          weather: convertedWeatherUnits,
        ),
      ),
    );
  }
}
