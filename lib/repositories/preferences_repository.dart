import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_explorer/models/country.dart';

class PreferencesRepository {
  Future<void> saveCountries(List<Country> countries) async {
    // Obtention de l'instance des SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> listJson = [];

    for (final Country country in countries) {
      // Sérialisation de l'objet company en Map<String, dynamic>
      final Map<String, dynamic> mapJson = country.toJson();

      // Transformation de la Map en String
      final String json = jsonEncode(mapJson);

      // Stockage du json dans une liste
      listJson.add(json);
    }

    // Sauvegarde de la liste
    prefs.setStringList('countries', listJson);
  }

  Future<List<Country>> loadCountries() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<Country> countries = [];

    // Récupère la liste si elle est déjà dans l'instance de Shared Preferences, sinon renvoie un tableau vide
    final List<String> countriesJson = prefs.getStringList('countries') ?? [];

    for(final String countryJson in countriesJson){
      
      final Map<String, dynamic> mapCountry = jsonDecode(countryJson);

      final Country country = Country.fromJson(mapCountry);
      countries.add(country);
    }
    return countries; 
  }
}