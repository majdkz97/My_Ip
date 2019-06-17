import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';
import 'package:my_ip/repositories/repositories.dart';
import 'package:my_ip/models/models.dart';
class CountriesDataBloc extends Bloc<CountriesDataEvent, CountriesDataState> {
  final  Country_allData country_allData;
  CountriesDataBloc({@required this.country_allData})
      : assert(country_allData != null);

  @override
  CountriesDataState get initialState => CountriesDataEmpty();

  @override
  Stream<CountriesDataState> mapEventToState(
    CountriesDataEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is FetchCountriesData)
      {
        yield CountriesDataLoading();
        try
            {
              final List<Country> countries = await country_allData.getCountry_allData();
              yield CountriesDataLoaded(countries: countries);
            }
            catch(_){
          yield CountriesDataError();
            }
      }
    if (event is RefreshCountriesData) {
      try
      {
        final List<Country> countries = await country_allData.getCountry_allData();
        yield CountriesDataLoaded(countries: countries);
      }
      catch(_){
        yield CountriesDataError();
      }
    }


  }
}

