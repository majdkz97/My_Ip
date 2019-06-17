import 'package:flutter/material.dart';
import 'package:my_ip/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_ip/widgets/CountryInfoTab/CountryTab_Page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:my_ip/blocs/countryData/bloc.dart';
import 'package:my_ip/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flare_flutter/flare_actor.dart';
class HomeTab extends StatefulWidget {
  final Info info;

  HomeTab({Key key, @required this.info})
      : assert(info != null),
        super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  Country _country;
  CountryBloc countryBloc;
  @override
  void initState() {
    _country = widget.info.country;
    countryBloc = CountryBloc(ip_country_info: Ip_Country_Info(httpClient:http.Client()));
    countryBloc.dispatch(FetchCountry(country_code: _country.alpha2Code));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: BlocProvider(
        bloc: countryBloc,
        child: Center(
          child: BlocBuilder(
            bloc: countryBloc,
            builder:(BuildContext context,CountryState state){


              if(state is CountryLoading)
              {
                return Container(

                  child: FlareActor('assets/load.flr',
                    animation: 'Loading',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,

                  ),
                );
              }

              if(state is CountryError)
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
                );              }
              if(state is CountryLoaded)
                return CountryTab_Page(country: state.country,);

              return Container();


            }
          ),
        ),
      ),
    );
  }
}





