import 'package:equatable/equatable.dart';


class Ip extends Equatable {
  final String ip;
  final String ip_cc;
  final String ip_country;


  Ip({
  this.ip,
    this.ip_cc,
    this.ip_country
  }) : super([
    ip,
    ip_cc,
    ip_country
  ]);

  static Ip fromJson(dynamic json) {

    return Ip(
      ip: json['ip'],
      ip_cc: json['cc'],
      ip_country: json['country'],
    );
  }

}
