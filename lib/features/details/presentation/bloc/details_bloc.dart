import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sample/features/details/domain/use_case/get_pokemon_details_use_case.dart';
import 'package:sample/features/details/presentation/bloc/details_events.dart';
import 'package:sample/features/details/presentation/bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetPokemonDetailsUseCase getPokemonDetailsUseCase;

  DetailsBloc({required this.getPokemonDetailsUseCase})
      : super(const DetailsState()) {
    on<GetPokemonDetailsEvent>(_getPokemonDetails);
    on<FetchedPokemonDetailsEvent>(_fetchedPokemonDetails);
    on<ErrorPokemonDetailsEvent>(_errorPokemonDetails);
    on<PickPokemonEvent>(_updateSelectedPokemon);
  }

  void _getPokemonDetails(GetPokemonDetailsEvent event, emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result =
        await getPokemonDetailsUseCase(state.pickedPokemon?.id ?? '');
    result.fold(
        (failure) => add(
            ErrorPokemonDetailsEvent(errorMessage: failure.message ?? 'Error')),
        (success) => add(FetchedPokemonDetailsEvent(pokemonDetails: success)));
  }

  void _fetchedPokemonDetails(FetchedPokemonDetailsEvent event, emit) {
    emit(state.copyWith(
        pokemonDetails: event.pokemonDetails,
        status: FormzSubmissionStatus.success));
  }

  void _errorPokemonDetails(ErrorPokemonDetailsEvent event, emit) {
    emit(state.copyWith(
        errorMessage: event.errorMessage,
        status: FormzSubmissionStatus.failure));
  }

  void _updateSelectedPokemon(PickPokemonEvent event, emit) {
    emit(state.copyWith(
      pickedPokemon: event.pokemonEntity,
    ));
  }
}
