import 'package:flutter/material.dart';
import 'package:world_explorer/repositories/pays_du_jour_repository.dart';

class PaysDuJour extends StatefulWidget {
  const PaysDuJour({Key? key}) : super(key: key);

  @override
  _PaysDuJourState createState() => _PaysDuJourState();
}

class _PaysDuJourState extends State<PaysDuJour> {
  late Future<dynamic> _paysDuJour;

  @override
  void initState() {
    super.initState();
    _paysDuJour = ApiService.fetchPaysDuJour();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pays du jour'),
      ),
      body: FutureBuilder(
        future: _paysDuJour,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Une erreur s\'est produite: ${snapshot.error}'),
            );
          } else {
            final country = snapshot.data[0]; // Récupérer le premier pays de la liste
            final population = country['population'];
            return SingleChildScrollView(
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
                        image: NetworkImage(country['flags']['png']),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Afficher le nom du pays
                  Text(
                    country['name']['common'],
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  // Afficher des informations diverses sur le pays
                  Text(
                    'Capitale: ${country['capital'][0]}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Population: $population',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Monnaie: ${country['currencies']['EUR']['name']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  // Ajoutez d'autres informations que vous souhaitez afficher
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
