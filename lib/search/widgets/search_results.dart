import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final ValueSetter<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) => _SearchResult(
        city: 'New York',
        onTap: () => onTap?.call('New York'),
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
    return ListTile(
      visualDensity: VisualDensity.compact,
      title: Text(city),
      onTap: onTap,
    );
  }
}
