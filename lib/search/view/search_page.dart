import 'package:blizzard/forecast/view/forecast_page.dart';
import 'package:blizzard/search/bloc/search_cubit.dart';
import 'package:blizzard/search/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_repository/weather_repository.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blizzard'),
      ),
      body: BlocProvider(
        create: (context) => SearchCubit(context.read<WeatherRepository>()),
        child: SearchForm(),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          SearchBar(
            onSubmitted: (city) =>
                context.read<SearchCubit>().searchForLocation(city.trim()),
          ),
          const SizedBox(height: 16),
          _SearchContent()
        ],
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.loading:
            return Center(child: CircularProgressIndicator());
          case SearchStatus.success:
            return _SearchSuccess(
              locations: state.locations,
            );
          case SearchStatus.failure:
            return Center(
              child: Text('Error searching for that location'),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class _SearchSuccess extends StatelessWidget {
  final List<Location> locations;

  const _SearchSuccess({Key? key, this.locations = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchResults(
      locations: locations,
      onTap: (locationId) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ForecastPage(
              locationId: locationId,
            ),
          ),
        );
      },
    );
  }
}
