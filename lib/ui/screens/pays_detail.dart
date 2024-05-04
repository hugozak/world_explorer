import 'package:flutter/material.dart';
import 'package:world_explorer/models/country.dart'; // Importez le modèle de pays si vous en avez un

class PaysDetail extends StatelessWidget {
  final Country country; // Utilisez le modèle de pays pour passer les données du pays

  const PaysDetail({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Afficher la photo du pays
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(country.flagLink),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(height: 16.0),
            // Afficher des informations spécifiques au pays
            Text(
              'Capitale: ${country.capital}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Population: ${country.population}',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Monnaie: ${country.currency}',
              style: const TextStyle(fontSize: 18.0),
            ),
            // Ajoutez d'autres informations spécifiques au pays ici
          ],
        ),
      ),
    );
  }
}