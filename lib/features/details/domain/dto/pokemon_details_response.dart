import 'package:sample/features/details/domain/entities/move_entity.dart';
import 'package:sample/features/details/domain/entities/stat_entity.dart';

class PokemonDetailsResponse {
  final String name;
  final num? height;
  final num? weight;
  final List<MoveEntity>? moves;
  final String imageUrl;
  final List<StatEntity>? stats;

  PokemonDetailsResponse(
      {required this.name,
      required this.height,
      required this.weight,
      required this.imageUrl,
      this.moves,
      this.stats});

  factory PokemonDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PokemonDetailsResponse(
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      imageUrl: json['sprites']['front_default'],
      moves: json['moves']
          .map<MoveEntity>((move) => MoveEntity.fromJson(move))
          .toList(),
      stats: json['stats']
          .map<StatEntity>((stat) => StatEntity.fromJson(stat))
          .toList(),
    );
  }
}
