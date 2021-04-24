import 'package:blizzard/forecast/bloc/forecast_cubit.dart';
import 'package:blizzard/forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_repository/weather_repository.dart';

class ForecastPage extends StatelessWidget {
  final int locationId;

  const ForecastPage({Key? key, required this.locationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
      ),
      body: BlocProvider(
        create: (context) => ForecastCubit(context.read<WeatherRepository>())
          ..fetchForecast(locationId),
        child: ForecastFrame(),
      ),
    );
  }
}

class ForecastFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastCubit, ForecastState>(
      bloc: context.read<ForecastCubit>(),
      builder: (context, state) {
        switch (state.status) {
          case ForecastStatus.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ForecastStatus.success:
            return _ForecastSuccess(
              forecast: state.forecast,
            );
          case ForecastStatus.failure:
            return Center(
              child: Text('Error fetching the forecast'),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class _ForecastSuccess extends StatelessWidget {
  final Forecast forecast;

  const _ForecastSuccess({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          TodaysWeather(
            forecast: forecast,
          ),
          const SizedBox(height: 32),
          ForecastResults(
            forecast: forecast,
          )
        ],
      ),
    );
  }
}
