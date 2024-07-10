import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/core/usecase.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';
import 'package:sample/features/home/domain/repository/poke_repository.dart';

class GetPokemonsUseCase
    extends UseCase<List<PokemonEntity>, GetPokemonsParams> {
  final PokeRepository repository;

  GetPokemonsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(
      GetPokemonsParams params) async {
    return await repository.getPokemons(
        limit: params.limit, offset: params.offset);
  }
}

class GetPokemonsParams {
  final int? limit;
  final int? offset;

  GetPokemonsParams({this.limit, this.offset});
}
