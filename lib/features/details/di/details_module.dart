import 'package:get_it/get_it.dart';
import 'package:sample/features/details/domain/use_case/get_pokemon_details_use_case.dart';
import 'package:sample/features/details/presentation/bloc/details_bloc.dart';

final sl = GetIt.instance;

Future<void> initModule() async {
  //======================= UseCases =======================///
  sl.registerFactory(() => GetPokemonDetailsUseCase(repository: sl()));

  //======================= Blocs =======================///
  sl.registerLazySingleton(() => DetailsBloc(getPokemonDetailsUseCase: sl()));
}
