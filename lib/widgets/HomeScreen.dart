import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:my_ip/widgets/utils/CustomShapeClipper.dart';
import 'package:my_ip/widgets/HomeTab/HomeTab.dart';
import 'package:my_ip/models/models.dart';
import 'package:my_ip/localizations.dart';
import 'package:my_ip/LocaleHelper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_ip/widgets/CountriesTab/CountriesTab.dart';
import 'dart:io';
import 'package:my_ip/repositories/shared_prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  final Info info;
  HomeScreen({Key key, @required this.info})
      : assert(info != null),
        super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 1);

    return Scaffold(

      body: Center(
        child: PageView(
        physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[


            CountriesTab(),

            HomeTab(info: widget.info,),
            Center(child: RaisedButton(
                child: Text('Language'),
                onPressed: (){
              if(true)
                {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                      title: Text( 'Choose Language'),
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
                        ListTile(
                          leading: Icon(Icons.text_fields),
                          title: Text('null'),
                          onTap: () => Navigator.pop(context, 'null'),
                        ),
                      ],
                    ),
                  ).then<String>((returnVal) {
                    if (returnVal != null) {
                      setState(() {
                        helper.onLocaleChanged( Locale(returnVal));
                        setid(returnVal);
                      });
                    }
                  });
                }

            }),)

          ],
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
          tabs: [

            TabData(iconData: Icons.flag, title: "Countries"),
            TabData(iconData: Icons.home, title: 'Home'),
            TabData(iconData: Icons.info, title: "About")
          ],
          onTabChangedListener: (int postion){
           // helper.onLocaleChanged( Locale("ar"));

            pageController.jumpToPage(postion);

          }
          ,

        circleColor:  Color.fromRGBO(242, 197, 124, 1.0),
        inactiveIconColor: Color.fromRGBO(6, 12, 76, 1.0),
      initialSelection: 1,
      ),
    );
  }
}
