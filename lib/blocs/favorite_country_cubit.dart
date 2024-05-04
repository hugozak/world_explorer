import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_explorer/models/country.dart';
import 'package:world_explorer/repositories/preferences_repository.dart';

class CountryCubit extends Cubit<List<Country>> {

  CountryCubit(this.preferencesRepository, List<Country> initialCountries) : super(initialCountries);

  final PreferencesRepository preferencesRepository;

  Future<void> loadCountries() async {
    final countries = await preferencesRepository.loadCountries();
    emit(countries);
  }

  Future<void> addCountry(Country country) async {
    final updatedFavorites = [...state, country];
    emit(updatedFavorites);
    await preferencesRepository.saveCountries(updatedFavorites);

  }

  Future<void> removeCountry(Country country) async {
    final updatedFavorites = state.where((c) => c.name != country.name).toList();
    emit(updatedFavorites);
    await preferencesRepository.saveCountries(updatedFavorites);
  }
}