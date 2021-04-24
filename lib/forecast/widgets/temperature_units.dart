import 'package:blizzard/forecast/bloc/forecast_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemperatureUnits extends StatelessWidget {
  final selectedTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final nonSelectedTextStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastCubit, ForecastState>(
        bloc: context.read<ForecastCubit>(),
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              context.read<ForecastCubit>().switchUnits();
            },
            child: Row(
              children: [
                Text('C\u00b0',
                    style: state.isCelsius
                        ? selectedTextStyle
                        : nonSelectedTextStyle),
                Text('/', style: TextStyle(fontSize: 20)),
                SizedBox(width: 4),
                Text('F\u00b0',
                    style: state.isCelsius
                        ? nonSelectedTextStyle
                        : selectedTextStyle),
              ],
            ),
          );
        });
  }
}
