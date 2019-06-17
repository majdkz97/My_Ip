import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:my_ip/models/models.dart';


class Country_allData {

  static const baseUrl = 'https://restcountries.eu/rest/v2/all?fields=name;alpha3Code;alpha2Code;callingCodes;region';
  final http.Client httpClient;

  Country_allData({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Country>> getCountry_allData() async {

    final counrtyResponse = await this.httpClient.get(baseUrl);
    if (counrtyResponse.statusCode != 200) {
      throw Exception('error getting locationId for ip');
    }
    List<Country> countries = List<Country>();
    final counrtyJson = jsonDecode(counrtyResponse.body) as List;
    for(var c in counrtyJson)
      countries.add(Country.fromJson(c)) ;

    return countries;
  }

}
