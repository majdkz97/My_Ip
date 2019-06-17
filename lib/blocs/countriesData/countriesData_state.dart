import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_ip/models/models.dart';
@immutable
abstract class CountriesDataState extends Equatable {
  CountriesDataState([List props = const []]) : super(props);
}


class CountriesDataEmpty extends CountriesDataState {}

class CountriesDataLoading extends CountriesDataState {}

class CountriesDataLoaded extends CountriesDataState {
  final  List<Country> countries;

  CountriesDataLoaded({@required this.countries})
      : assert(countries != null),
        super([countries]);
}

class CountriesDataError extends CountriesDataState {}