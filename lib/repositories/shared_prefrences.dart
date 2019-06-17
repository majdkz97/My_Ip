import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

setid(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', id);
  print('*********' + prefs.getString('id'));
}
setUpid(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('upid', id);

}
Future<String> getUpid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('upid');


  return id;
}
setnewA(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('newA', id);

}
Future<String> getnewA() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('newA');


  return id;
}

setNotf(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('notf', id);
  print('Set Notf '+ prefs.getString('notf'));

}
Future<String> getNotf() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('notf');
  print('Get Notf '+id);


  return id;
}


Future<String> getid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('id');
  print('***/////' + id);

  return id;
}


Future<dynamic> getData() async {
  final response =
  await http.get("http://fakeapigenerater.000webhostapp.com/status.php");
  return jsonDecode(response.body);
}
