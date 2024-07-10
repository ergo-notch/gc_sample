import 'package:sample/core/network/http-client/http_client_service.dart';
import 'package:sample/features/details/domain/dto/pokemon_details_response.dart';
import 'package:sample/features/home/domain/dto/pokemon_list_response.dart';

import '../../domain/data_source/poke_data_source.dart';

class PokeDataSourceImpl extends PokeDataSource {
  final HttpClientService client;

  PokeDataSourceImpl({required this.client});

  @override
  Future<PokemonListResponse> getPokemons({int? limit, int? offset}) async {
    final response = await client.get(
      path: '/pokemon',
      params: {
        'limit': limit,
        'offset': offset,
      },
    );
    final pokemonListResponse = PokemonListResponse.fromJson(response);
    return pokemonListResponse;
  }

  @override
  Future<PokemonDetailsResponse> getPokemonDetails(
      {required String pokemonId}) async {
    final response = await client.get(
      path: '/pokemon/$pokemonId',
    );
    final pokemonDetailsResponse = PokemonDetailsResponse.fromJson(response);
    return pokemonDetailsResponse;
  }
}
