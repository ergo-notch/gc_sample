import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/core/usecase.dart';
import 'package:sample/features/details/domain/entities/pokemon_details_entity.dart';
import 'package:sample/features/home/domain/repository/poke_repository.dart';

class GetPokemonDetailsUseCase extends UseCase<PokemonDetailsEntity, String> {
  final PokeRepository repository;

  GetPokemonDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, PokemonDetailsEntity>> call(String params) async {
    return await repository.getPokemonDetails(pokemonId: params);
  }
}
