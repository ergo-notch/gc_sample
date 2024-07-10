import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/core/usecase.dart';

import 'add_favorite_use_case.dart';

class RemoveFavoriteUseCase
    extends UseCase<List<String>?, FavoriteUseCaseParams> {
  @override
  Future<Either<Failure, List<String>?>> call(
      FavoriteUseCaseParams params) async {
    List<String> favorites = List.of(params.favoritesIds ?? []);
    favorites.remove(params.pokemon?.id ?? '');
    return Right(favorites);
  }
}
