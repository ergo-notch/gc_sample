import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/features/details/domain/entities/pokemon_details_entity.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

abstract class PokeRepository {
  Future<Either<Failure, List<PokemonEntity>>> getPokemons(
      {int? limit, int? offset});

  Future<Either<Failure, PokemonDetailsEntity>> getPokemonDetails({
    required String pokemonId,
  });
}
