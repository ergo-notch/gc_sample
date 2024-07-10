import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/core/utils/app_images.dart';
import 'package:sample/core/utils/extensions.dart';
import 'package:sample/features/details/presentation/bloc/details_bloc.dart';
import 'package:sample/features/details/presentation/bloc/details_events.dart';
import 'package:sample/features/details/presentation/bloc/details_state.dart';
import 'package:sample/features/home/presentation/bloc/home_bloc.dart';
import 'package:sample/features/home/presentation/bloc/home_events.dart';

import '../../home/presentation/ui/pokemon_tile.dart';
import 'ui/details_tab_view.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final detailsBloc = context.read<DetailsBloc>();
      detailsBloc.add(GetPokemonDetailsEvent());
      isFavorite = detailsBloc.state.pickedPokemon?.isFavorite ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (_, state) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: isFavorite
                  ? const Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.red,
                      size: 35,
                    )
                  : const Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                      size: 35,
                    ),
              onPressed: () {
                context.read<HomeBloc>().add(UpdateFavoritePokemonEvent(
                    pokemonEntity:
                        state.pickedPokemon?.copyWith(isFavorite: isFavorite)));
                setState(() => isFavorite = !isFavorite);
              },
            ),
          ],
          centerTitle: true,
          title: Text(
            (state.pickedPokemon?.name ?? '').capitalize(),
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Hero(
                  tag: state.pickedPokemon?.id ?? '',
                  child: Container(
                      height: 300,
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      child: Card(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(children: [
                            BackgroundColorByNetworkImage(
                                imageUrl: state.pokemonDetails?.imageUrl ??
                                    AppImages.pokeballImage),
                            Center(
                              child: Image.network(
                                  state.pokemonDetails?.imageUrl ?? '',
                                  fit: BoxFit.cover,
                                  height: 300,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                        AppImages.pokeballImage,
                                        fit: BoxFit.cover,
                                      ),
                                  loadingBuilder: (context, child,
                                          loadingProgress) =>
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
                                            ))),
                            ),
                          ])))),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '${state.pokemonDetails?.height?.toStringAsFixed(1) ?? ''} M',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Height',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Image.asset(
                    AppImages.typeImage,
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        '${state.pokemonDetails?.weight?.toStringAsFixed(1) ?? ''} KG',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Weight',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              const DatailsTabView()
            ],
          ),
        ),
      ),
    );
  }
}
