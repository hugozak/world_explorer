import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_explorer/blocs/favorite_country_cubit.dart';
import 'package:world_explorer/repositories/preferences_repository.dart';
import 'package:world_explorer/ui/screens/pays_du_jour.dart';
import 'package:world_explorer/ui/screens/liste_des_pays.dart';
import 'package:world_explorer/ui/screens/mes_pays_favoris.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final preferencesRepository = PreferencesRepository();
  final CountryCubit countryCubit = CountryCubit(preferencesRepository);
  countryCubit.loadCountries();

  runApp(BlocProvider<CountryCubit>(
    create: (_) => countryCubit,
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const PaysDuJour(),
    const ListeDesPays(),
    const MesPaysFavoris()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("World explorer"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Pays du jour',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Liste des pays'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Mes pays favoris'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}