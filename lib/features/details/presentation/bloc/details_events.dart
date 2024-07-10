import 'package:equatable/equatable.dart';
import 'package:sample/features/details/domain/entities/pokemon_details_entity.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonDetailsEvent extends DetailsEvent {
  @override
  List<Object> get props => [];
}

class PickPokemonEvent extends DetailsEvent {
  final PokemonEntity? pokemonEntity;

  const PickPokemonEvent({required this.pokemonEntity});

  @override
  List<Object> get props => [pokemonEntity ?? PokemonEntity()];
}

class FetchedPokemonDetailsEvent extends DetailsEvent {
  final PokemonDetailsEntity pokemonDetails;

  const FetchedPokemonDetailsEvent({required this.pokemonDetails});

  @override
  List<Object> get props => [pokemonDetails];
}

class ErrorPokemonDetailsEvent extends DetailsEvent {
  final String errorMessage;

  const ErrorPokemonDetailsEvent({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
