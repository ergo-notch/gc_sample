import 'package:sample/features/details/domain/dto/pokemon_details_response.dart';
import 'package:sample/features/home/domain/dto/pokemon_list_response.dart';

abstract class PokeDataSource {
  Future<PokemonListResponse> getPokemons({int? limit, int? offset});
  Future<PokemonDetailsResponse> getPokemonDetails({required String pokemonId});
}
