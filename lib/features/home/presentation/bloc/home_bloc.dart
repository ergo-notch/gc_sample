import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sample/features/home/domain/use_case/add_favorite_use_case.dart';
import 'package:sample/features/home/domain/use_case/get_pokemons_use_case.dart';
import 'package:sample/features/home/domain/use_case/match_favorites_use_case.dart';
import 'package:sample/features/home/domain/use_case/remove_favorite_use_case.dart';
import 'package:sample/features/home/domain/use_case/search_pokemon_by_text_use_case.dart';
import 'package:sample/features/home/presentation/bloc/home_events.dart';
import 'package:sample/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPokemonsUseCase getPokemonsUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final SearchPokemonByTextUseCase searchPokemonByTextUseCase;
  final MatchFavoritesUseCase matchFavoritesUseCase;

  HomeBloc({
    required this.getPokemonsUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.searchPokemonByTextUseCase,
    required this.matchFavoritesUseCase,
  }) : super(const HomeState()) {
    on<GetPokemonsEvent>(_getPokemons);
    on<FetchedPokemonsEvent>(_fetchedPokemons);
    on<FailedFetchPokemonsEvent>(_failedFetchPokemons);
    on<GetMoreResultsEvent>(_getMoreResults);
    on<FetchedMorePokemonsEvent>(_fetchedMorePokemons);
    on<AddFavoritePokemonEvent>(_addFavoritePokemon);
    on<RemoveFavoritePokemonEvent>(_removeFavoritePokemon);
    on<UpdateFavoritePokemonEvent>(_updateFavoritePokemon);
    on<SearchPokemonByTextEvent>(_searchPokemonByText);
    on<ClearSearchTextEvent>(_clearSearchText);
    on<UpdateSearchTextEvent>(_updateSearchText);
    on<FoundedPokemonsEvent>(_foundedPokemons);
    on<MatchFavoritePokemonsEvent>(_matchFavoritePokemons);
  }

  void _getPokemons(GetPokemonsEvent event, emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result =
        await getPokemonsUseCase(GetPokemonsParams(limit: 0, offset: 20));
    result.fold(
        (failure) => add(FailedFetchPokemonsEvent(message: failure.message)),
        (success) => add(FetchedPokemonsEvent(pokemons: success)));
  }

  void _fetchedPokemons(FetchedPokemonsEvent event, emit) {
    emit(state.copyWith(
        pokemons: event.pokemons,
        searchResults: event.pokemons,
        status: FormzSubmissionStatus.success,
        limit: event.pokemons.length));
  }

  void _failedFetchPokemons(FailedFetchPokemonsEvent event, emit) {
    emit(state.copyWith(
        errorMessage: event.message, status: FormzSubmissionStatus.failure));
  }

  void _getMoreResults(GetMoreResultsEvent event, emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await getPokemonsUseCase(
        GetPokemonsParams(limit: state.limit, offset: state.limit + 20));
    result.fold(
        (failure) => add(FailedFetchPokemonsEvent(message: failure.message)),
        (success) => add(FetchedMorePokemonsEvent(pokemons: success)));
  }

  void _fetchedMorePokemons(FetchedMorePokemonsEvent event, emit) {
    emit(state.copyWith(
        pokemons: [...state.pokemons, ...event.pokemons],
        searchResults: [...state.pokemons, ...event.pokemons],
        limit: [...state.pokemons, ...event.pokemons].length,
        status: FormzSubmissionStatus.success));
  }

  void _updateFavoritePokemon(UpdateFavoritePokemonEvent event, emit) {
    if (event.pokemonEntity?.isFavorite ?? false) {
      add(RemoveFavoritePokemonEvent(pokemonEntity: event.pokemonEntity));
    } else {
      add(AddFavoritePokemonEvent(pokemonEntity: event.pokemonEntity));
    }
  }

  Future<void> _addFavoritePokemon(AddFavoritePokemonEvent event, emit) async {
    final searchResult = await addFavoriteUseCase.call(FavoriteUseCaseParams(
        pokemon: event.pokemonEntity, favoritesIds: state.favoritesIds));
    searchResult.fold(
        (failure) => add(FailedFetchPokemonsEvent(message: failure.message)),
        (success) =>
            add(MatchFavoritePokemonsEvent(favoritesIds: success ?? [])));
  }

  Future<void> _removeFavoritePokemon(
      RemoveFavoritePokemonEvent event, emit) async {
    final result = await removeFavoriteUseCase.call(FavoriteUseCaseParams(
        pokemon: event.pokemonEntity, favoritesIds: state.favoritesIds));
    result.fold(
        (failure) => add(FailedFetchPokemonsEvent(message: failure.message)),
        (success) =>
            add(MatchFavoritePokemonsEvent(favoritesIds: success ?? [])));
  }

  void _updateSearchText(UpdateSearchTextEvent event, emit) {
    emit(state.copyWith(searchText: event.searchText));
    add(SearchPokemonByTextEvent(searchText: event.searchText));
  }

  Future<void> _searchPokemonByText(
      SearchPokemonByTextEvent event, emit) async {
    final result = await searchPokemonByTextUseCase.call(
        SearchPokemonByTextUseCaseParams(
            searchText: state.searchText, pokemons: state.pokemons));
    result.fold(
        (failure) => add(FailedFetchPokemonsEvent(message: failure.message)),
        (success) => add(FoundedPokemonsEvent(pokemons: success)));
  }

  void _clearSearchText(ClearSearchTextEvent event, emit) {
    emit(state.copyWith(searchText: '', searchResults: state.pokemons));
  }

  FutureOr<void> _foundedPokemons(FoundedPokemonsEvent event, emit) {
    emit(state.copyWith(searchResults: event.pokemons));
  }

  Future<void> _matchFavoritePokemons(
      MatchFavoritePokemonsEvent event, emit) async {
    final result = await matchFavoritesUseCase.call(MatchFavoritePokemonsParams(
        favoritesIds: event.favoritesIds,
        pokemons: state.pokemons,
        searchResults: state.searchResults));
    result.fold(
        (failure) => add(FailedFetchPokemonsEvent(message: failure.message)),
        (success) => emit(state.copyWith(
            favoritesIds: event.favoritesIds,
            pokemons: success.pokemons,
            searchResults: success.searchResults)));
  }
}
