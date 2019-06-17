import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:my_ip/models/models.dart';

class Ip_location {

  static const baseUrl = 'https://api.myip.com';
  final http.Client httpClient;

  Ip_location({@required this.httpClient}) : assert(httpClient != null);

  Future<Ip> getLocationId() async {

    final locationResponse = await this.httpClient.get(baseUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for ip');
    }

    final locationJson = jsonDecode(locationResponse.body);
    return Ip.fromJson(locationJson);
  }

}
