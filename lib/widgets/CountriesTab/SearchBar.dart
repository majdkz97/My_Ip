import 'package:flutter/material.dart';
import 'package:my_ip/models/models.dart';
class SearchBar extends StatefulWidget {
  final List<Country> countries;
  final List<Country> countriesDisplay;

  SearchBar({Key key, @required this.countries,@required this.countriesDisplay})
      : assert(countries != null),
        super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
   List<Country> _countries;
   List<Country> _countriesDisplay;


  @override
  void initState() {
    _countries = widget.countries;
    _countriesDisplay = widget.countriesDisplay;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search...'
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _countriesDisplay = _countries.where((country) {
              var countryTitle = country.name.toLowerCase();
              return countryTitle.contains(text);
            }).toList();
          });
        },
      ),
    );

  }
}



