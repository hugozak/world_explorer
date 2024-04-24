import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_explorer/models/country.dart';
import 'package:world_explorer/repositories/preferences_repository.dart';

class CountryCubit extends Cubit<List<Country>> {

  CountryCubit(this.preferencesRepository) : super([]);

  final PreferencesRepository preferencesRepository;

  Future<void> loadCountries() async {
    final countries = await preferencesRepository.loadCountries();
    emit(countries);
  }

  Future<void> addCountry(Country country) async {
    emit([...state, country]);
    await preferencesRepository.saveCountries(state);
  }
}