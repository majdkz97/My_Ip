import 'package:meta/meta.dart';
import 'package:my_ip/models/models.dart';
import 'package:my_ip/repositories/ip_location.dart';
import 'package:my_ip/repositories/ip_counrty_info.dart';


class Ip_Repositories {
  final Ip_location ip_location;
  final Ip_Country_Info ip_country_info;

  Ip_Repositories({@required this.ip_location ,@required this.ip_country_info })
      : assert(Ip_Repositories != null);

  Future<Info> getData() async {
    final Ip locationId = await ip_location.getLocationId();
    final Country country_info = await ip_country_info.getCountryInfo(locationId.ip_cc);

    return new Info(ip: locationId,country: country_info);
  }
}
