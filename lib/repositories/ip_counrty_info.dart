import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:my_ip/models/models.dart';


class Ip_Country_Info {

  static const baseUrl = 'https://restcountries.eu/rest/v2/alpha/';
  final http.Client httpClient;

  Ip_Country_Info({@required this.httpClient}) : assert(httpClient != null);

  Future<Country> getCountryInfo(String ccId) async {

    final counrtyResponse = await this.httpClient.get(baseUrl+ccId);
    if (counrtyResponse.statusCode != 200) {
      throw Exception('error getting locationId for ip');
    }

    final counrtyJson = jsonDecode(counrtyResponse.body);
    return Country.fromJson(counrtyJson);
  }

}
