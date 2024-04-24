import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_explorer/blocs/favorite_country_cubit.dart';
import 'package:world_explorer/models/country.dart';

class MesPaysFavoris extends StatelessWidget {
  const MesPaysFavoris({super.key});

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
              itemCount: favoriteCountries.length,
              itemBuilder: (context, index){
                final country = favoriteCountries[index];
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