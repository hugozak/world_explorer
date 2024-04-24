import 'package:flutter/material.dart';
import 'package:world_explorer/models/country.dart';

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
            Text('Nom: ${country.name}')
          ],
        )
      )
    );
  }
}