import 'dart:convert';

import 'package:world_explorer/models/country.dart';
import 'package:http/http.dart';

class CountryRepository {

  Future<List<Country>> fetchCountries(String query) async {
    final Response response = await get(Uri.parse('https://restcountries.com/v3.1/translation/$query'));
    if(response.statusCode == 200){
      List<Country> countries = [];

      final List<dynamic> jsonList = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      for (var json in jsonList) {
        final Country country = Country.fromJson(json);
        countries.add(country);
      }
      return countries;
    } else{
      return [];
    }
  }

  Future<List<Country>> getAllCountries() async {
    final Response response = await get(Uri.parse('https://restcountries.com/v3.1/all?fields=capital,currencies,flags,translations,population'));
    if(response.statusCode == 200) {
      List<Country> countries = [];
      final List<dynamic> jsonList = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      for(var json in jsonList) {
        final Country country = Country.fromJson(json);
        countries.add(country);
      }
      return countries;
    } else {
      throw Exception("Failed to load country");
    }
  }
}