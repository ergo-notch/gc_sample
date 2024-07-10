import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/core/usecase.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

class AddFavoriteUseCase extends UseCase<List<String>?, FavoriteUseCaseParams> {
  @override
  Future<Either<Failure, List<String>?>> call(
      FavoriteUseCaseParams params) async {
    List<String> favorites = List.of(params.favoritesIds ?? []);
    favorites.add(params.pokemon?.id ?? '');
    return Right(favorites);
  }
}

class FavoriteUseCaseParams {
  final PokemonEntity? pokemon;
  final List<String>? favoritesIds;

  FavoriteUseCaseParams({
    required this.favoritesIds,
    required this.pokemon,
  });
}
