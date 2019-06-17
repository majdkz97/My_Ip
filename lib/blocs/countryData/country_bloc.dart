import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';
import 'package:my_ip/repositories/ip_counrty_info.dart';
import 'package:my_ip/models/models.dart';
class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final Ip_Country_Info ip_country_info;
  CountryBloc({@required this.ip_country_info})
      : assert(ip_country_info != null);

  @override
  CountryState get initialState => CountryEmpty();

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is FetchCountry)
      {
        yield CountryLoading();
        try
            {
              final Country country = await ip_country_info.getCountryInfo(event.country_code);
              yield CountryLoaded(country: country);
            }
            catch(_){
          yield CountryError();
            }
      }
    if (event is RefreshCountry) {
      try {
        final Country country = await ip_country_info.getCountryInfo(event.country_code);
        yield CountryLoaded(country: country);
      } catch (_) {
        yield CountryError();
      }
    }


  }
}

