import 'package:formz/formz.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

class HomeState {
  final List<PokemonEntity> pokemons;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final int limit;
  final List<PokemonEntity> searchResults;
  final List<String> favoritesIds;
  final String? searchText;

  const HomeState({
    this.pokemons = const [],
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.limit = 20,
    this.searchResults = const [],
    this.searchText,
    this.favoritesIds = const [],
  });

  HomeState copyWith(
      {List<PokemonEntity>? pokemons,
      FormzSubmissionStatus? status,
      String? errorMessage,
      int? limit,
      List<PokemonEntity>? searchResults,
      String? searchText,
      List<String>? favoritesIds}) {
    return HomeState(
      pokemons: pokemons ?? this.pokemons,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      limit: limit ?? this.limit,
      searchResults: searchResults ?? this.searchResults,
      searchText: searchText ?? this.searchText,
      favoritesIds: favoritesIds ?? this.favoritesIds,
    );
  }
}
