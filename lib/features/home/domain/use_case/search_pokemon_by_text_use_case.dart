import 'package:dartz/dartz.dart';
import 'package:sample/core/error/failures.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

import '../../../../core/usecase.dart';

class SearchPokemonByTextUseCase
    extends UseCase<List<PokemonEntity>, SearchPokemonByTextUseCaseParams> {
  @override
  Future<Either<Failure, List<PokemonEntity>>> call(
      SearchPokemonByTextUseCaseParams params) async {
    List<PokemonEntity> pokemons = List.of(params.pokemons ?? []);
    List<PokemonEntity> result = List.of([]);
    if (params.searchText != null && params.searchText!.isNotEmpty) {
      result = pokemons
          .where((x) => (x.name ?? '')
              .toLowerCase()
              .contains((params.searchText ?? '').toLowerCase()))
          .toList();
    }
    return Right(result);
  }
}

class SearchPokemonByTextUseCaseParams {
  final String? searchText;
  final List<PokemonEntity>? pokemons;

  SearchPokemonByTextUseCaseParams(
      {required this.searchText, required this.pokemons});
}
