import 'package:equatable/equatable.dart';
import 'dart:convert';

class Country extends Equatable {
  final String name;
  final List<dynamic> topLevelDomain;
  final String alpha2Code;
  final String alpha3Code;
  final List<dynamic> callingCodes;
  final String capital;
  final List<dynamic> altSpellings;
  final String region;
  final String subregion;
  final String population;
  final List<dynamic> latlng;
  final String area;
  final List<dynamic> timezones;
  final String nativeName;
  final List<dynamic> currencies;

  final List<dynamic> languages;
  final String flag;

  Country({this.name, this.topLevelDomain, this.alpha2Code, this.alpha3Code, this.callingCodes,
    this.capital, this.altSpellings, this.region,
    this.subregion, this.population, this.latlng,
    this.area, this.timezones, this.nativeName,
    this.currencies,
    this.languages, this.flag}

      ):super([name,topLevelDomain,alpha2Code,alpha3Code,callingCodes,capital,
 altSpellings,region, subregion,population,latlng,
    area,timezones,nativeName,currencies,
    languages,flag
  ]);



  static Country fromJson(dynamic json) {

    return Country(
      name: json['name'],

      topLevelDomain: json['topLevelDomain']  as List,
      alpha2Code: json['alpha2Code'],
      alpha3Code: json['alpha3Code'],
      capital: json['capital'],
      callingCodes: json['callingCodes'] as List,
      altSpellings: json['altSpellings'] as List,
      region: json['region'],
      subregion: json['subregion'],
      population: json['population'].toString(),
      latlng: json['latlng'] as List,
      area: json['area'].toString(),
      timezones: json['timezones'] as List,
      nativeName: json['nativeName'],
      currencies:json['currencies'] as List,
      languages: json['languages'] as List,
      flag: json['flag'],



    );
  }

}
