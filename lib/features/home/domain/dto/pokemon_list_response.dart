import 'package:sample/features/home/domain/dto/pokemon_preview_dto.dart';

class PokemonListResponse {
  final int? count;
  final String? next;
  final String? previous;

  final List<PokemonPreviewDto>? results;

  PokemonListResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((x) => PokemonPreviewDto.fromJson(x))
          .toList(),
    );
  }
}
