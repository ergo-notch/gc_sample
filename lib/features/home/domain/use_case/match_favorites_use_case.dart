import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

import '../../../../core/usecase.dart';

class MatchFavoritesUseCase
    extends UseCase<MatchFavoritePokemonsResult, MatchFavoritePokemonsParams> {
  @override
  Future<Either<Failure, MatchFavoritePokemonsResult>> call(
      MatchFavoritePokemonsParams params) async {
    List<PokemonEntity> pokemons = List.of(params.pokemons ?? []);
    List<PokemonEntity> search = List.of(params.searchResults ?? []);
    final pokemonResults = pokemons.map((pokemon) {
      if (params.favoritesIds.contains(pokemon.id)) {
        return pokemon.copyWith(isFavorite: true);
      } else {
        return pokemon.copyWith(isFavorite: false);
      }
    }).toList();
    final searchResults = search.map((pokemon) {
      if (params.favoritesIds.contains(pokemon.id)) {
        return pokemon.copyWith(isFavorite: true);
      } else {
        return pokemon.copyWith(isFavorite: false);
      }
    }).toList();

    return Right(MatchFavoritePokemonsResult(
      pokemons: pokemonResults,
      searchResults: searchResults,
    ));
  }
}

class MatchFavoritePokemonsParams {
  final List<String> favoritesIds;
  final List<PokemonEntity>? pokemons;
  final List<PokemonEntity>? searchResults;

  MatchFavoritePokemonsParams({
    required this.favoritesIds,
    required this.pokemons,
    required this.searchResults,
  });
}

class MatchFavoritePokemonsResult {
  final List<PokemonEntity>? pokemons;
  final List<PokemonEntity>? searchResults;

  MatchFavoritePokemonsResult({
    required this.pokemons,
    required this.searchResults,
  });
}
