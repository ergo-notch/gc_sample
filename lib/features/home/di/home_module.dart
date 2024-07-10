import 'package:get_it/get_it.dart';
import 'package:sample/features/home/data/data_source/poke_data_source_impl.dart';
import 'package:sample/features/home/data/repository/poke_repository_impl.dart';
import 'package:sample/features/home/domain/data_source/poke_data_source.dart';
import 'package:sample/features/home/domain/repository/poke_repository.dart';
import 'package:sample/features/home/domain/use_case/get_pokemons_use_case.dart';
import 'package:sample/features/home/domain/use_case/match_favorites_use_case.dart';
import 'package:sample/features/home/domain/use_case/remove_favorite_use_case.dart';
import 'package:sample/features/home/presentation/bloc/home_bloc.dart';

import '../domain/use_case/add_favorite_use_case.dart';
import '../domain/use_case/search_pokemon_by_text_use_case.dart';

final sl = GetIt.instance;

Future<void> initModule() async {
  //======================= Datasources =======================///
  sl.registerFactory<PokeDataSource>(() => PokeDataSourceImpl(client: sl()));

  //======================= Repositories =======================///
  sl.registerFactory<PokeRepository>(
    () => PokeRepositoryImpl(dataSource: sl()),
  );

  //======================= UseCases =======================///
  sl.registerFactory(() => GetPokemonsUseCase(repository: sl()));

  sl.registerFactory(() => AddFavoriteUseCase());

  sl.registerFactory(() => RemoveFavoriteUseCase());

  sl.registerFactory(() => SearchPokemonByTextUseCase());

  sl.registerFactory(() => MatchFavoritesUseCase());

  //======================= Blocs =======================///
  sl.registerLazySingleton(() => HomeBloc(
      getPokemonsUseCase: sl(),
      addFavoriteUseCase: sl(),
      removeFavoriteUseCase: sl(),
      searchPokemonByTextUseCase: sl(),
      matchFavoritesUseCase: sl()));
}
