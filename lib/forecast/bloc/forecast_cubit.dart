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
}
