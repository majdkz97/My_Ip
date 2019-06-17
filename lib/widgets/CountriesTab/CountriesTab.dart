import 'package:flutter/material.dart';
import 'package:my_ip/models/models.dart';
import 'SearchBar.dart';
import 'ListViewItem_country.dart';
import 'package:my_ip/blocs/countriesData/bloc.dart';
import 'package:my_ip/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CountriesTab_Page.dart';
import 'package:flare_flutter/flare_actor.dart';
class CountriesTab extends StatefulWidget {


  @override
  _CountriesTabState createState() => _CountriesTabState();
}

class _CountriesTabState extends State<CountriesTab> {
  CountriesDataBloc countriesDataBloc;

  @override
  void dispose() {
    countriesDataBloc.dispose();
    super.dispose();

  }

  @override
  void initState() {
    countriesDataBloc = CountriesDataBloc(
        country_allData:
        Country_allData(httpClient: http.Client()));
    countriesDataBloc.dispatch(FetchCountriesData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      bloc: countriesDataBloc,
      child: Center(
        child: BlocBuilder(
         bloc: countriesDataBloc,
          builder: (BuildContext context,CountriesDataState state){
            if(state is CountriesDataLoading)
            {
              return Container(

                child: FlareActor('assets/load.flr',
                  animation: 'Loading',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,

                ),
              );
            }

            if(state is CountriesDataError)
            {
              return Container(
                margin: EdgeInsets.only(left: 5.0,bottom: 100),
                child: Container(

                  child: FlareActor('assets/no_network (1).flr',
                    animation: 'go',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,

                  ),
                ),
              );
            }
            if(state is CountriesDataLoaded)
              return CountriesTab_Page(countries: state.countries);

            return Container();

          },
        ),
      ),
    );

  }
}

