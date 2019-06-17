import 'package:flutter/material.dart';
import 'package:my_ip/localizations.dart';
import 'package:my_ip/models/models.dart';
import 'ListViewItem_country.dart';
import 'package:my_ip/widgets/CountryInfoTab/HomeTab.dart';
class CountriesTab_Page extends StatefulWidget {
  final List<Country> countries;
  CountriesTab_Page({Key key, @required this.countries})
      : assert(countries != null),
        super(key: key);
  @override
  _CountriesTab_PageState createState() => _CountriesTab_PageState();
}

class _CountriesTab_PageState extends State<CountriesTab_Page> with SingleTickerProviderStateMixin {
 List<Country> countriesDisplay;
 Animation animation ;
 AnimationController animationController;
 String searchText;
 @override
 void initState()  {
   countriesDisplay = widget.countries;
   animationController = AnimationController(
       duration: Duration(seconds: 2),vsync: this
   );

   animation = Tween(begin: -1.0,end: 0.0).animate(
       CurvedAnimation(parent: animationController,
           curve: Interval(0.0,1.0,curve:  Curves.fastOutSlowIn))
   );


   animationController.forward();
   searchText = 'Country Name';
   for( var _country in widget.countries)
     {
       _country.callingCodes[0] = '+' + _country.callingCodes[0];

     }
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
      builder: (BuildContext context,Widget child){

        return  Stack(
          children: <Widget>[
            //Blue Background
            Container(
              color: Color.fromRGBO(6, 12, 76, 1.0),
              height: double.infinity,
              width: double.infinity,
            ),
            //ListView
            Transform(
              transform: Matrix4.translationValues
                (-1.0*animation.value * width, 0.0, 0.0) ,
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10 + 15),
                child: ListView.builder(
                  itemCount: countriesDisplay.length,
                  itemBuilder: (context,i)
                  {
                    return  GestureDetector(
                      onTap: (){
                        Navigator.of(super.context).push(MaterialPageRoute(

                            builder: (BuildContext context){
                              return Center(
                                child: HomeTab(info: Info(country: countriesDisplay[i],ip: Ip()),),
                              );
                            }
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListViewItem_country(country: countriesDisplay[i],),
                      ),
                    );
                  },
                ),
              ),
            ),
            //SearchBar
            Transform(
              transform: Matrix4.translationValues
                (animation.value * width, 0.0, 0.0) ,
              child: Container(
                margin: EdgeInsets.only(top: 25),
                height: MediaQuery.of(context).size.height / 9,
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 197, 124, 1.0),
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0))),
                child: Center(
                    child:            Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                           child: Stack(
                             children: <Widget>[
                               Container(
                                 width: width/3 * 2 - 20,
                                 child: TextField(
                                   decoration: InputDecoration(
                                     hintText: AppLocalizations.of(context).searchBy,
                                     icon:Icon( Icons.search,color: Colors.white,),
                                     fillColor: Colors.white,
                                     counterStyle: TextStyle(color: Colors.white)
                                     ,
                                     focusedBorder: UnderlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),

                                     )
                                     ,


                                   ),
                                   onChanged: (text) {
                                     text = text.toLowerCase();
                                   text=  replaceArabicNumber(text);
                                     setState(() {
                                       countriesDisplay = widget.countries.where((country) {
                                         switch(searchText)
                                         {
                                           case 'Country Name':
                                             {
                                               var countryTitle = country.name.toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           case 'اسم الدولة':
                                             {
                                               var countryTitle = country.name.toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           case 'Landesname':
                                             {
                                               var countryTitle = country.name.toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           case 'Calling Codes':
                                             {
                                               var countryTitle = country.callingCodes[0].toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           case 'رموز الاتصال':
                                             {
                                               var countryTitle = country.callingCodes[0].toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           case 'Vorwahlnummer':
                                             {
                                               var countryTitle = country.callingCodes[0].toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           case 'Region':
                                             {
                                               var countryTitle = country.region.toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           case 'المنطقة':
                                             {
                                               var countryTitle = country.region.toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           case 'Country Region':
                                             {
                                               var countryTitle = country.region.toLowerCase();
                                               return countryTitle.contains(text);
                                             }
                                             break;
                                           default: {
                                             //statements;
                                           }
                                           break;

                                         }


                                       }).toList();
                                     });
                                   },
                                 ),
                               ),
                               Container(
                                 alignment: Alignment.centerRight,
                                 child:
                                 RaisedButton(
                                   color: Colors.yellow,
                                   elevation: 5,
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                   child: Text(searchText),
                                   onPressed: () {
                                     showDialog<String>(
                                       context: context,
                                       builder: (BuildContext context) => SimpleDialog(
                                         title: Text( AppLocalizations.of(context).searchBy),
                                         children: <Widget>[
                                           ListTile(
                                             leading: Icon(Icons.text_fields),
                                             title: Text( AppLocalizations.of(context).countryName),
                                             onTap: () => Navigator.pop(context, AppLocalizations.of(context).countryName),
                                           ),
                                           ListTile(
                                             leading: Icon(Icons.phone_in_talk),
                                             title: Text(AppLocalizations.of(context).callingCodes),
                                             onTap: () => Navigator.pop(context, AppLocalizations.of(context).callingCodes),
                                           ),
                                           ListTile(
                                             leading: Icon(Icons.flag),
                                             title: Text(AppLocalizations.of(context).region),
                                             onTap: () => Navigator.pop(context, AppLocalizations.of(context).region),
                                           ),
                                         ],
                                       ),
                                     ).then<String>((returnVal) {
                                       if (returnVal != null) {
                                         setState(() {
                                           searchText = returnVal;
                                         });
                                       }
                                     });
                                   },
                                 ),
                               ),
                             ],
                           ),
                        )


                    )


                ),
              ),
            ),


          ],
        );
      },
    );


  }
}

String replaceArabicNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi =  ['٠', '١', '٢','٣','٤', '٥','٦','٧','٨','٩'];


  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(farsi[i], english[i]);
  }

  return input;
}