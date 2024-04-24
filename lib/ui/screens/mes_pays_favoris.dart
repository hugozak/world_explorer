import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_explorer/blocs/favorite_country_cubit.dart';
import 'package:world_explorer/models/country.dart';
import 'package:world_explorer/repositories/preferences_repository.dart';

class MesPaysFavoris extends StatefulWidget {
  const MesPaysFavoris({super.key});

  @override
  _MesPaysFavorisState createState() => _MesPaysFavorisState();
}

class _MesPaysFavorisState extends State<MesPaysFavoris>{

  List<Country> _favoriteCountries = [];

  @override
  void initState(){
    super.initState();
    _loadFavoriteCountries();
  }

  Future<void> _loadFavoriteCountries() async {
    final preferencesRepository = PreferencesRepository();
    final favoriteCountries = await preferencesRepository.loadCountries();
    setState(() {
      _favoriteCountries = favoriteCountries;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes pays favoris')
      ),
      body: BlocBuilder<CountryCubit, List<Country>>(
        builder: (context, favoriteCountries) {
          if(favoriteCountries.isEmpty) {
            return const Center(
              child: Text('Aucun pays favori.')
            );
          } else {
            return ListView.builder(
              itemCount: _favoriteCountries.length,
              itemBuilder: (context, index){
                final country = _favoriteCountries[index];
                return ListTile(
                  title: Text(country.name),
                );
              },
            );
          }
        }
      ),
    );
  }
}