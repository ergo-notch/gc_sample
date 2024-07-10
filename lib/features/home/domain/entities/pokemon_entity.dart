import 'package:sample/features/home/domain/dto/pokemon_preview_dto.dart';

class PokemonEntity {
  final String? id;
  final String? name;
  final String? urlImage;
  final bool? isFavorite;

  PokemonEntity({
    this.id,
    this.name,
    this.urlImage,
    this.isFavorite,
  });

  factory PokemonEntity.dtoToEntity({PokemonPreviewDto? dto}) {
    final id = dto?.url?.split('/').elementAt(6);
    return PokemonEntity(
      id: id,
      name: dto?.name,
      urlImage:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      isFavorite: false,
    );
  }

  PokemonEntity copyWith({
    String? id,
    String? name,
    String? urlImage,
    bool? isFavorite,
  }) {
    return PokemonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      urlImage: urlImage ?? this.urlImage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
