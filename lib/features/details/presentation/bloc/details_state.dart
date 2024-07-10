import 'package:formz/formz.dart';
import 'package:sample/features/details/domain/entities/pokemon_details_entity.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

class DetailsState {
  final PokemonDetailsEntity? pokemonDetails;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final PokemonEntity? pickedPokemon;

  const DetailsState(
      {this.pokemonDetails,
      this.status = FormzSubmissionStatus.initial,
      this.errorMessage,
      this.pickedPokemon});

  DetailsState copyWith(
      {PokemonDetailsEntity? pokemonDetails,
      FormzSubmissionStatus? status,
      String? errorMessage,
      PokemonEntity? pickedPokemon}) {
    return DetailsState(
        pokemonDetails: pokemonDetails ?? this.pokemonDetails,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        pickedPokemon: pickedPokemon ?? this.pickedPokemon);
  }
}
