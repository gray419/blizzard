import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int id;
  final String name;

  Location(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}
