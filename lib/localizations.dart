import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }
 


  String get ip {
    return Intl.message('Your IP is', name: 'ip');
  }
  String get nativeName {
    return Intl.message('Native Name', name: 'nativeName');
  }
  String get capital {
    return Intl.message('Capital', name: 'capital');
  }
  String get region {
    return Intl.message('Region', name: 'region');
  }
  String get subRegion {
    return Intl.message('Sub Region', name: 'subRegion');
  }
  String get population {
    return Intl.message('Population', name: 'population');
  }
  String get area {
    return Intl.message('Area', name: 'area');
  }
  String get coordinates {
    return Intl.message('Coordinates', name: 'coordinates');
  }
  String get languages {
    return Intl.message('Languages', name: 'languages');
  }
  String get countryDomain {
    return Intl.message('Country Domain', name: 'countryDomain');
  }
  String get callingCodes {
    return Intl.message('Calling Codes', name: 'callingCodes');
  }
  String get timeZones {
    return Intl.message('Time Zones', name: 'timeZones');
  }

  String get currencies {
    return Intl.message('Currencies', name: 'currencies');
  }
  String get searchBy {
    return Intl.message('Search By', name: 'searchBy');
  }
  String get countryName {
    return Intl.message('Country Name', name: 'countryName');
  }


}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}

class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar','de'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) => SynchronousFuture<_DefaultCupertinoLocalizations>(_DefaultCupertinoLocalizations(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
  final Locale locale;
  
  _DefaultCupertinoLocalizations(this.locale);

 
}
