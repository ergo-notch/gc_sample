import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/features/details/domain/entities/pokemon_details_entity.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

import '../../domain/data_source/poke_data_source.dart';
import '../../domain/repository/poke_repository.dart';

class PokeRepositoryImpl extends PokeRepository {
  final PokeDataSource dataSource;

  PokeRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemons(
      {int? limit, int? offset}) async {
    try {
      final response =
          await dataSource.getPokemons(limit: limit, offset: offset);
      final result = response.results
          ?.map((x) => PokemonEntity.dtoToEntity(dto: x))
          .toList();
      return Right(result ?? []);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PokemonDetailsEntity>> getPokemonDetails(
      {required String pokemonId}) async {
    try {
      final response = await dataSource.getPokemonDetails(pokemonId: pokemonId);
      final result = PokemonDetailsEntity.dtoToEntity(dto: response);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
