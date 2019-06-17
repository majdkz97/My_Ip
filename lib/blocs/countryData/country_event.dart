import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountryEvent extends Equatable {
  CountryEvent([List props = const []]) : super(props);
}


class FetchCountry extends CountryEvent {
  String country_code;

  FetchCountry({ @required this.country_code
  }
      ):super([country_code]);

}

class RefreshCountry extends CountryEvent {

  String country_code;

  RefreshCountry({ @required this.country_code
  }
      ):super([country_code]);
}