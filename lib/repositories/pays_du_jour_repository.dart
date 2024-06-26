import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> fetchPaysDuJour() async {
    // Appel API avec le nom france par manque de temps de faire du random
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/name/france'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
