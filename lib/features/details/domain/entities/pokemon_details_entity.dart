import 'package:sample/features/details/domain/dto/pokemon_details_response.dart';
import 'package:sample/features/details/domain/entities/move_entity.dart';
import 'package:sample/features/details/domain/entities/stat_entity.dart';

class PokemonDetailsEntity {
  final String name;
  final num? height;
  final num? weight;
  final List<MoveEntity>? moves;
  final String imageUrl;
  final List<StatEntity>? stats;

  PokemonDetailsEntity({
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    this.moves,
    this.stats,
  });

  factory PokemonDetailsEntity.dtoToEntity(
      {required PokemonDetailsResponse dto}) {
    final moves =
        (dto.moves ?? []).length >= 8 ? dto.moves?.sublist(0, 8) : dto.moves;
    return PokemonDetailsEntity(
      name: dto.name,
      height: (dto.height ?? 0) * 0.1,
      weight: (dto.weight ?? 0) * 0.1,
      imageUrl: dto.imageUrl,
      moves: moves,
      stats: dto.stats,
    );
  }
}
