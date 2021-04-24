import 'package:flutter/material.dart';
import 'package:weather_repository/weather_repository.dart';

class SearchResults extends StatelessWidget {
  final ValueSetter<int>? onTap;
  final List<Location> locations;

  SearchResults({Key? key, this.onTap, this.locations = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: locations.length,
      itemBuilder: (context, index) => _SearchResult(
        city: locations[index].name,
        onTap: () => onTap?.call(locations[index].id),
      ),
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({
    Key? key,
    required this.city,
    this.onTap,
  }) : super(key: key);

  final String city;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(city), onTap: onTap);
  }
}
