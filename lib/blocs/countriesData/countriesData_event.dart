import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountriesDataEvent extends Equatable {
  CountriesDataEvent([List props = const []]) : super(props);
}


class FetchCountriesData extends CountriesDataEvent {
  FetchCountriesData();

}

class RefreshCountriesData extends CountriesDataEvent {
  RefreshCountriesData();

}