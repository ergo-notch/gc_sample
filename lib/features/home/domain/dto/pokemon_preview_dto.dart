class PokemonPreviewDto {
  final String? name;
  final String? url;

  PokemonPreviewDto({
    this.name,
    this.url,
  });

  factory PokemonPreviewDto.fromJson(Map<String, dynamic> json) {
    return PokemonPreviewDto(
      name: json['name'],
      url: json['url'],
    );
  }
}
