import 'package:flutter/material.dart';
import 'package:my_ip/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:my_ip/models/models.dart';
import 'package:my_ip/blocs/data/bloc.dart';
import 'package:my_ip/blocs/countryData/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ip/widgets/HomeScreen.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';
import 'LocaleHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:store_redirect/store_redirect.dart';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_ip/repositories/shared_prefrences.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  Ip_Repositories ip_repositories = Ip_Repositories(
      ip_location: Ip_location(httpClient: http.Client()),
      ip_country_info: Ip_Country_Info(httpClient: http.Client()));

  BlocSupervisor().delegate = SimpleBlocDelegate();

  runApp(myMaterial(
    ip_repositories: ip_repositories,
  ));
}

class myMaterial extends StatefulWidget {
  Ip_Repositories ip_repositories;
  myMaterial({Key key, @required this.ip_repositories})
      : assert(ip_repositories != null),
        super(key: key);
  @override
  _myMaterialState createState() => _myMaterialState();
}

class _myMaterialState extends State<myMaterial> {
  Ip_Repositories ip_repositories;
  SpecificLocalizationDelegate _specificLocalizationDelegate;

  @override
  void initState() {
    ip_repositories = widget.ip_repositories;
    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(new Locale("en"));
    setNotf('null');
    super.initState();
  }

  @override
  onLocaleChange(Locale locale) {
    setState(() {
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,

          //app-specific localization
          _specificLocalizationDelegate
        ],
        supportedLocales: [Locale('en'), Locale('ar'), Locale('de')],
        locale: _specificLocalizationDelegate.overriddenLocale,
        home: App(ip_repositories: ip_repositories));
  }
}


class App extends StatefulWidget {
  final Ip_Repositories ip_repositories;

  App({Key key, @required this.ip_repositories})
      : assert(ip_repositories != null),
        super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  DataBloc _dataBloc;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    _dataBloc = DataBloc(ip_repositories: widget.ip_repositories);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(
        initSettings, onSelectNotification: selectNotification );


    var x = "en";

    bool first = true;
    getid().then((value) {
      print('6666' + value);
      if(value!= 'null')
        {
          setState(() {
            x = value;
            first = false;
            helper.onLocaleChanged(Locale(x));
          });
        }

    });
    print('6666' + x);
    super.initState();


    getData().then((value) {
      print(value);
      if (value['ver'] != '1.0') {
        print('update');
        Navigator.of(context).pop();
        setUpid(value['upidA']);
        showNotification('Update This Application To ${value['ver']}','Your version is 1.0','update');

        showDialog<String>(
          context: context,

          builder: (BuildContext context) => new AlertDialog(
            title: new Text("Hello"),
            content: new Text("Please Update This Application"),

            actions: <Widget>[
              new FlatButton(
                child: new Text("Update"),
                onPressed: () {
                  Navigator.of(context).pop();
                  StoreRedirect.redirect(androidAppId: "${value['upidA']}",
                      iOSAppId: "${value['upidI']}");
                  exit(0);
                },
              ),
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                  exit(0);

                },
              ),

            ],
          ),
        );
      }
      else if (value['newN'] != 'no') {
        print('new App');
        setnewA(value['newA']);
        showNotification('We recomend you to download our new app','${value['newN']}', 'new');

        showDialog<String>(
          context: context,

          builder: (BuildContext context) => new AlertDialog(
            title: new Text("Hello"),
            content: new Text("We recomend you to download our new app \n${value['newN']}"),

            actions: <Widget>[
              new FlatButton(
                child: new Text("download"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _dataBloc.dispatch(FetchData());
                  StoreRedirect.redirect(androidAppId: "${value['newA']}",
                      iOSAppId: "${value['newI']}");
                  //    exit(0);
                },
              ),
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  _dataBloc.dispatch(FetchData());
                  Navigator.of(context).pop();


                },
              ),

            ],
          ),
        );
      }


      else {
        print('Normal');

        _dataBloc.dispatch(FetchData());
                  if (first) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => SimpleDialog(
                        title: Text('Chose Lang'),
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.text_fields),
                            title: Text('Arabic'),
                            onTap: () => Navigator.pop(context, 'ar'),
                          ),
                          ListTile(
                            leading: Icon(Icons.text_fields),
                            title: Text('English'),
                            onTap: () => Navigator.pop(context, 'en'),
                          ),
                          ListTile(
                            leading: Icon(Icons.text_fields),
                            title: Text('German'),
                            onTap: () => Navigator.pop(context, 'de'),
                          ),
                        ],
                      ),
                    ).then<String>((returnVal) {
                      if (returnVal != null) {
                        setState(() {
                          setid(returnVal);
                          helper.onLocaleChanged(Locale(returnVal));

                        });
                      }
                    });
                  }

                  else {
                    helper.onLocaleChanged(Locale(x));

                  }

      }



    });

    _dataBloc.dispatch(FetchData());


  }


  showNotification(String title,String text,String cn) async{
    var android = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription"
        ,priority: Priority.High,importance: Importance.Max);
    var iOS = new IOSNotificationDetails();

    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, '${title}', '${text}' , platform,payload: cn);

  }


  Future selectNotification(String payload){
    debugPrint('print payload : $payload');
    if(payload=='update')
      {
        getUpid().then((value){
          StoreRedirect.redirect(androidAppId: "$value");
          exit(0);
        });
      }
    else if(payload == 'new')
      {
        getnewA().then((value){
          StoreRedirect.redirect(androidAppId: "$value");

        });
      }
    else
      {

      }

  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
      bloc: _dataBloc,
      child: Scaffold(
          body: Container(
        child: Center(
          child: BlocBuilder(
              bloc: _dataBloc,
              builder: (BuildContext context, DataState state) {
                if (state is DataLoading) {
                  return Container(
                    child: FlareActor(
                      'assets/load.flr',
                      animation: 'Loading',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    ),
                  );
                }

                if (state is DataError) {
                  return Container(
                    margin: EdgeInsets.only(left: 5.0, bottom: 100),
                    child: Container(
                      child: FlareActor(
                        'assets/no_network (1).flr',
                        animation: 'go',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }
                if (state is DataLoaded)
                  {
                    getNotf().then((value){
                      if(value=='null')
                        {
                          showNotification('${AppLocalizations.of(context).ip}: '+state.info.ip.ip,'${AppLocalizations.of(context).countryName}: '+state.info.country.name,'notf');
                          setNotf('Notified');

                        }
                    });
                    return HomeScreen(info: state.info);
                  }

                return Container();
              }),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _dataBloc.dispose();
    super.dispose();
  }
}

