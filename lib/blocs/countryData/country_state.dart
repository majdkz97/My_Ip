import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_ip/models/models.dart';
@immutable
abstract class CountryState extends Equatable {
  CountryState([List props = const []]) : super(props);
}


class CountryEmpty extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final  Country country;

  CountryLoaded({@required this.country})
      : assert(country != null),
        super([country]);
}

class CountryError extends CountryState {}