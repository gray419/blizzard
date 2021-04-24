part of 'search_cubit.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<Location> locations;

  const SearchState._(
      {this.status = SearchStatus.initial, this.locations = const []});

  const SearchState.initial() : this._();

  const SearchState.loading() : this._(status: SearchStatus.loading);

  const SearchState.success(List<Location> locations)
      : this._(status: SearchStatus.success, locations: locations);

  const SearchState.failure() : this._(status: SearchStatus.failure);

  @override
  List<Object> get props => [status, locations];
}
