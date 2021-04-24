import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final WeatherRepository _weatherRepository;

  SearchCubit(this._weatherRepository) : super(SearchState.initial());

  Future<void> searchForLocation(String term) async {
    emit(SearchState.loading());
    try {
      final locations = await _weatherRepository.searchForLocation(term: term);
      emit(SearchState.success(locations));
    } catch (e) {
      emit(SearchState.failure());
    }
  }
}
