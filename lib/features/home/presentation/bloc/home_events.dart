import 'package:equatable/equatable.dart';

import '../../domain/entities/pokemon_entity.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonsEvent extends HomeEvent {
  final int? limit;
  final int? offset;

  const GetPokemonsEvent({this.limit, this.offset});

  @override
  List<Object> get props => [limit ?? 0, offset ?? 0];
}

class FetchedPokemonsEvent extends HomeEvent {
  final List<PokemonEntity> pokemons;

  const FetchedPokemonsEvent({required this.pokemons});

  @override
  List<Object> get props => [pokemons];
}

class FailedFetchPokemonsEvent extends HomeEvent {
  final String? message;

  const FailedFetchPokemonsEvent({required this.message});

  @override
  List<Object> get props => [message ?? 'Error'];
}

class GetMoreResultsEvent extends HomeEvent {
  final int? limit;
  final int? offset;

  const GetMoreResultsEvent({this.limit, this.offset});

  @override
  List<Object> get props => [limit ?? 0, offset ?? 0];
}

class FetchedMorePokemonsEvent extends HomeEvent {
  final List<PokemonEntity> pokemons;

  const FetchedMorePokemonsEvent({required this.pokemons});

  @override
  List<Object> get props => [pokemons];
}

class UpdateFavoritePokemonEvent extends HomeEvent {
  final PokemonEntity? pokemonEntity;

  const UpdateFavoritePokemonEvent({required this.pokemonEntity});

  @override
  List<Object> get props => [pokemonEntity ?? PokemonEntity()];
}

class AddFavoritePokemonEvent extends HomeEvent {
  final PokemonEntity? pokemonEntity;

  const AddFavoritePokemonEvent({required this.pokemonEntity});

  @override
  List<Object> get props => [pokemonEntity ?? PokemonEntity()];
}

class RemoveFavoritePokemonEvent extends HomeEvent {
  final PokemonEntity? pokemonEntity;

  const RemoveFavoritePokemonEvent({required this.pokemonEntity});

  @override
  List<Object> get props => [pokemonEntity ?? PokemonEntity()];
}

class SearchPokemonByTextEvent extends HomeEvent {
  final String? searchText;

  const SearchPokemonByTextEvent({required this.searchText});

  @override
  List<Object> get props => [searchText ?? ''];
}

class UpdateSearchTextEvent extends HomeEvent {
  final String? searchText;

  const UpdateSearchTextEvent({required this.searchText});

  @override
  List<Object> get props => [searchText ?? ''];
}

class ClearSearchTextEvent extends HomeEvent {
  const ClearSearchTextEvent();

  @override
  List<Object> get props => [];
}

class FoundedPokemonsEvent extends HomeEvent {
  final List<PokemonEntity> pokemons;

  const FoundedPokemonsEvent({required this.pokemons});

  @override
  List<Object> get props => [pokemons];
}

class MatchFavoritePokemonsEvent extends HomeEvent {
  final List<String> favoritesIds;

  const MatchFavoritePokemonsEvent({required this.favoritesIds});

  @override
  List<Object> get props => [favoritesIds];
}
