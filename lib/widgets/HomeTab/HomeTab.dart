import 'package:flutter/material.dart';
import 'package:my_ip/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_ip/widgets/HomeTab/widgets.dart';

import '../../localizations.dart';

class HomeTab extends StatefulWidget {
  final Info info;

  HomeTab({Key key, @required this.info})
      : assert(info != null),
        super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimayion;
  AnimationController animationController;

  Country _country;
  Ip _ip;
  @override
  void initState() {
    _country = widget.info.country;
    _ip = widget.info.ip;
    animationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.6, curve: Curves.fastOutSlowIn)));
    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.8, curve: Curves.fastOutSlowIn)));
    muchDelayedAnimayion = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn)));

    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Stack(
          children: <Widget>[
            //Blue Container
            Container(
              height: double.infinity,
              // color: Colors.grey,
              decoration: BoxDecoration(
                color: Color.fromRGBO(6, 12, 76, 1.0),
              ),
            ),
            //Yellow Container
            Transform(
              transform:
                  Matrix4.translationValues(0.0, animation.value * width, 0.0),
              child: Container(
                height: height / 4,
                width: double.infinity,
                // color: Colors.grey,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 197, 124, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60.0),
                        bottomRight: Radius.circular(60.0))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        AppLocalizations.of(context).ip,
                        maxLines: 1,
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                      ),
                      AutoSizeText(
                        '${_ip.ip}',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Info Container
            Container(
                margin: EdgeInsets.only(top: height / 4),
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0.0, 0.0),
                              child: Container(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.redAccent,
                                        size: 40,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                      ),
                                      AutoSizeText(
                                        '${_country.name}',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                width: width / 2 - 20,
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  -1.0 * delayedAnimation.value * width,
                                  0.0,
                                  0.0),
                              child: GestureDetector(
                                onTap: () =>
                                    _showSecondPage(context,
                                        'assets/${_country.alpha2Code.toLowerCase()}.png',
                                        '${_country.alpha2Code.toLowerCase()}'),

                                child: Hero(
                                  tag: 'hero ${_country.alpha2Code.toLowerCase()}',

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: width / 2,
                                      height: height / 5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/${_country.alpha2Code.toLowerCase()}.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform(
                          transform: Matrix4.translationValues(0.0,
                              -1.0 * muchDelayedAnimayion.value * width, 0.0),
                          child: Container(
                            width: width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //nativeName
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.text_fields,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).nativeName,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                              Icons.text_fields,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)                                            )
                                          ],
                                        ),
                                        AutoSizeText(
                                          '${_country.nativeName}',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),
                                //capital
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_city,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).capital,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                              Icons.location_city,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),

                                        AutoSizeText(
                                          '${_country.capital}',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),
                                //Region
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.map,
                                              color: Color.fromRGBO(
                                              242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).region,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                              Icons.map,
                                              color: Color.fromRGBO(
                                                  242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),


                                        AutoSizeText(
                                          '${_country.region}',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),
                                //Sub Region
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.location_on,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).subRegion,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.location_on,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),


                                        AutoSizeText(
                                          '${_country.subregion}',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                //Population
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.people,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).population,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.people,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),

                                        AutoSizeText(
                                          '${_country.population}',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                //Area
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.zoom_out_map,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).area,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.zoom_out_map,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),


                                        AutoSizeText(
                                          '${_country.area}',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                //Coordinates
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.my_location,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).coordinates,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.my_location,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),


                                        AutoSizeText(
                                          'Latitude: ${_country.latlng[0]}\nLongitude: ${_country.latlng[1]}',
                                          maxLines: 2,textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                //languages
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.language,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).languages,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.language,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),


                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                        ),
                                        Container(
                                          height: 100,
                                          //  color: Colors.red,
                                          width: (_country.languages.length
                                                  .toDouble() *
                                              (width / 5 + 6)),
                                          child: ListView.builder(
                                              itemCount:
                                                  _country.languages.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, i) {
                                                return ListViewItem_language(
                                                    list:
                                                        _country.languages[i]);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                //currencies
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.monetization_on,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).currencies,                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.monetization_on,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),


                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                        ),
                                        Container(
                                          height: 120,
                                          //  color: Colors.red,
                                          width: (_country.currencies.length
                                                  .toDouble() *
                                              (width / 5 + 6)),
                                          child: ListView.builder(
                                              itemCount:
                                                  _country.currencies.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, i) {
                                                return ListViewItem_currencie(
                                                    list:
                                                        _country.currencies[i]);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                //callingCodes
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.call,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).callingCodes,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.call,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),

                                         Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                        ),
                                        Container(
                                          height: 100,
                                          //  color: Colors.red,
                                          width: (_country.callingCodes.length
                                                  .toDouble() *
                                              (width / 5 + 6)),
                                          child: ListView.builder(
                                              itemCount:
                                                  _country.callingCodes.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, i) {
                                                return ListViewItem_callingcode(
                                                    list: _country
                                                        .callingCodes[i]
                                                        .toString());
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                //topLevelDomain
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.wifi_tethering,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).countryDomain,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.wifi_tethering,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),


                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                        ),
                                        Container(
                                          height: 100,
                                          //  color: Colors.red,
                                          width: (_country.topLevelDomain.length
                                                  .toDouble() *
                                              (width / 5 + 6)),
                                          child: ListView.builder(
                                              itemCount: _country
                                                  .topLevelDomain.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, i) {
                                                return ListViewItem_domain_times(
                                                    list: _country
                                                        .topLevelDomain[i]
                                                        .toString());
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                //timezones
                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                                Icons.access_time,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            ),
                                            SizedBox(width: 10,),
                                            AutoSizeText(
                                              AppLocalizations.of(context).timeZones,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.normal,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                                Icons.access_time,
                                                color: Color.fromRGBO(
                                                    242, 197, 124, 1.0)
                                            )
                                          ],
                                        ),

                                         Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                        ),
                                        Container(
                                          height: 100,
                                          //  color: Colors.red,
                                          width: (_country.timezones.length
                                                  .toDouble() *
                                              (width / 5 + 6)),
                                          child: ListView.builder(
                                              itemCount:
                                                  _country.timezones.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, i) {
                                                return ListViewItem_domain_times(
                                                    list: _country.timezones[i]
                                                        .toString());
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 50.0),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        );
      },
    );
  }
}

void _showSecondPage(BuildContext context,String url,String id) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: GestureDetector(
            onTap: Navigator.of(ctx).pop,
            child: Container(
              color: Colors.transparent,
              child: Hero(

                tag: 'hero ${id}',
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(url),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
  )
  );
}