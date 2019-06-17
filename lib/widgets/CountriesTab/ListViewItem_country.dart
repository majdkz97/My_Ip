import 'package:flutter/material.dart';
import 'package:my_ip/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:core';

class ListViewItem_country extends StatelessWidget {
  final Country country;

  ListViewItem_country({Key key, @required this.country})
      : assert(country != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    //print('${country.alpha2Code} ** ${country.alpha3Code}\nhttps://restcountries.eu/data/${country.alpha3Code.toLowerCase()}.svg');

    return Container(
      margin: EdgeInsets.only(left: 5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: Colors.grey.shade100,

        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
          Expanded(
            child: Container(

              child: Center(
                child: AutoSizeText(
                  '${country.name}',maxLines: 2,textAlign: TextAlign.center,
                  style: TextStyle(fontSize:30,fontWeight: FontWeight.bold, color: Colors.cyan),
                ),

              ),
            ),
          ),
          Container(

              width: MediaQuery.of(context).size.width/2.8,

              height:MediaQuery.of(context).size.height/7,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                      image: AssetImage('assets/${country.alpha2Code.toLowerCase()}.png'),
                      fit: BoxFit.fill
                  )
              ),


            ),


]
      )
    );
  }
}
