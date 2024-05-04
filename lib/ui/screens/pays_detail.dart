import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_explorer/blocs/favorite_country_cubit.dart';
import 'package:world_explorer/models/country.dart';
import 'package:world_explorer/repositories/preferences_repository.dart';

class PaysDetail extends StatelessWidget{
  final Country country;

  const PaysDetail({super.key, required this.country});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nom: ${country.name}'),
            ElevatedButton(
              onPressed: () => {
               _saveCountryToFavorite(context, country) 
              },
              child: const Text('Ajouter aux favoris')
            )
          ],
        )
      )
    );
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