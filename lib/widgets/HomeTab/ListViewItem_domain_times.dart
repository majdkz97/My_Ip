import 'package:flutter/material.dart';
import 'package:my_ip/models/models.dart';
import 'package:auto_size_text/auto_size_text.dart';



class ListViewItem_domain_times extends StatelessWidget {
  final String list;

  ListViewItem_domain_times({Key key, @required this.list})
      : assert(list != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: MediaQuery.of(context).size.width/5,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: Colors.grey.shade100,

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AutoSizeText(
            '${list}',maxLines: 1,textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold, color: Colors.black),
          ),


        ],
      ),
    );
  }
}
