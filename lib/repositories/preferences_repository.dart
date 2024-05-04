import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_explorer/models/country.dart';

class PreferencesRepository {
  Future<void> saveCountries(List<Country> countries) async {
    // Obtention de l'instance des SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Récupération des pays déjà enregistrés
    final List<String> existingJsonList = prefs.getStringList('countries') ?? [];

    // Ajout des nouveaux pays à la liste existante
    final List<String> updatedJsonList = [...existingJsonList];

    for (final Country country in countries) {
      // Sérialisation de l'objet company en Map<String, dynamic>
      final Map<String, dynamic> mapJson = country.toJson();

      // Transformation de la Map en String
      final String json = jsonEncode(mapJson);

      // Si il est déjà dans la liste ne pas l'ajouter
      if (!updatedJsonList.contains(json)) {
        updatedJsonList.add(json);
      }
    }

    // Sauvegarde de la liste
    prefs.setStringList('countries', updatedJsonList);
  }

  Future<List<Country>> loadCountries() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<Country> countries = [];

    // Récupère la liste si elle est déjà dans l'instance de Shared Preferences, sinon renvoie un tableau vide
    final List<String> countriesJson = prefs.getStringList('countries') ?? [];

    for(final String countryJson in countriesJson){
      
      final Map<String, dynamic> mapCountry = jsonDecode(countryJson);

      final Country country = Country.fromJsonClear(mapCountry);
      countries.add(country);
    }
    return countries; 
  }

  Future<void> removeCountry(Country country) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> countriesJson = prefs.getStringList('countries') ?? [];

    countriesJson.removeWhere((json) {
      final Country favoriteCountry = Country.fromJsonClear(jsonDecode(json));
      return favoriteCountry.name == country.name;
    });

    await prefs.setStringList('countries', countriesJson);
  }
}