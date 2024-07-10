import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/core/usecase.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

import 'add_favorite_use_case.dart';

class RemoveFavoriteUseCase
    extends UseCase<List<PokemonEntity>?, FavoriteUseCaseParams> {
  @override
  Future<Either<Failure, List<PokemonEntity>?>> call(
      FavoriteUseCaseParams params) async {
    List<PokemonEntity> result = List.of(params.pokemons ?? []);
    final index =
        result.indexWhere((element) => element.id == params.pokemon?.id);
    if (index != -1) {
      result[index] =
          params.pokemon?.copyWith(isFavorite: false) ?? PokemonEntity();
    }
    return Right(result);
  }
}
