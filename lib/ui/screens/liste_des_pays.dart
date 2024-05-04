import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_explorer/blocs/favorite_country_cubit.dart';
import 'package:world_explorer/models/country.dart';
import 'package:world_explorer/repositories/liste_des_pays_repository.dart';
import 'package:world_explorer/repositories/preferences_repository.dart';
import 'package:world_explorer/ui/screens/pays_detail.dart';

class ListeDesPays extends StatefulWidget {
  const ListeDesPays({super.key});

  @override 
  State<ListeDesPays> createState() => _ListeDesPaysState();
}

class _ListeDesPaysState extends State<ListeDesPays> {
  final CountryRepository _listeDesPaysRepository = CountryRepository();
  List<dynamic> _listeDesPays = [];

  @override
  void initState() {
    super.initState();
    _chargerListeDesPays();
  }

  Future<void> _chargerListeDesPays({String? query}) async {
    final listePays = query != null && query.isNotEmpty
        ? await _listeDesPaysRepository.fetchCountries(query)
        : await _listeDesPaysRepository.getAllCountries();
    
    if(this.mounted){
      setState(() {
        _listeDesPays = listePays;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chercher un pays"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: _chercherPays,
            decoration: const InputDecoration(
              hintText: 'Saisir un pays',
              border: OutlineInputBorder()
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listeDesPays.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${_listeDesPays[index].name}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_listeDesPays[index].flagLink),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      _saveCountryToFavorite(context, _listeDesPays[index]);
                    }
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PaysDetail(country: _listeDesPays[index])
                    ));
                  },
                );
              },  
            )
          )
        ]
      )
    );
  }

  void _chercherPays(String value) {
    if (value.length >= 3) {
      _chargerListeDesPays(query: value);
    } else {
      _chargerListeDesPays();
    }
  }
}

Future<void> _saveCountryToFavorite(BuildContext context, Country country) async {
  final preferencesRepository = PreferencesRepository();
  final List<Country> countries = [country];
  await preferencesRepository.saveCountries(countries);

  final countryCubit = BlocProvider.of<CountryCubit>(context);

  countryCubit.addCountry(country);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${country.name} ajouté aux favoris'),
      duration: const Duration(seconds: 2),
    )
  );
}