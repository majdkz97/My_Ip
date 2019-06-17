import 'package:equatable/equatable.dart';
import 'package:my_ip/models/models.dart';

class Info extends Equatable {
  final Country country;
  final Ip ip;


  Info({
    this.ip,
    this.country
  }) : super([
    ip,
    country
  ]);


}
