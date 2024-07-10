import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/core/utils/extensions.dart';
import 'package:sample/features/home/domain/entities/pokemon_entity.dart';

import '../../../../core/utils/app_images.dart';

class PokemonTile extends StatelessWidget {
  final PokemonEntity? pokemon;
  final Function(PokemonEntity?) onSelectPokemon;
  final Function(PokemonEntity?) onUpdateFavorite;

  const PokemonTile(
      {super.key,
      this.pokemon,
      required this.onSelectPokemon,
      required this.onUpdateFavorite});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black,
        child: InkWell(
          onTap: () => onSelectPokemon(pokemon),
          child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(children: [
                BackgroundColorByNetworkImage(
                    imageUrl: pokemon?.urlImage ?? AppImages.pokeballImage),
                Column(
                  children: [
                    Expanded(
                        child: Image.network(pokemon?.urlImage ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  AppImages.pokeballImage,
                                  fit: BoxFit.cover,
                                ),
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress == null
                                    ? child
                                    : Center(
                                        child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      )))),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 10, bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                                    pokemon?.name?.capitalize() ?? 'Pokemon',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 20)
                          ]),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () => onUpdateFavorite(pokemon),
                      child: (pokemon?.isFavorite ?? false)
                          ? const Icon(CupertinoIcons.heart_fill,
                              color: Colors.red, size: 30)
                          : const Icon(CupertinoIcons.heart,
                              color: Colors.white, size: 30),
                    ),
                  ),
                )
              ])),
        ));
  }
}

class BackgroundColorByNetworkImage extends StatelessWidget {
  final String? imageUrl;

  const BackgroundColorByNetworkImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final image = Image.network(imageUrl ?? '');
    return FutureBuilder(
        future: ColorScheme.fromImageProvider(provider: image.image),
        builder: (ctx, snap) {
          final color = snap.data?.primaryContainer;
          return Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color ?? Colors.black,
                  Colors.grey[600] ?? Colors.black
                ],
              ),
            ),
          );
        });
  }
}
