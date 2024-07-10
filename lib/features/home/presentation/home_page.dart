import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/core/utils/app_images.dart';
import 'package:sample/features/details/presentation/bloc/details_bloc.dart';
import 'package:sample/features/details/presentation/bloc/details_events.dart';
import 'package:sample/features/home/presentation/bloc/home_events.dart';
import 'package:sample/features/home/presentation/bloc/home_state.dart';
import 'package:sample/features/home/presentation/ui/pokemon_tile.dart';
import 'package:sample/features/home/presentation/ui/search_pokemon_field.dart';
import 'package:sample/routes/navigator.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final homeBloc = context.read<HomeBloc>();
    homeBloc.add(const GetPokemonsEvent());

    scrollController.addListener(() {
      var nextPageTrigger = 0.9 * scrollController.position.maxScrollExtent;

      if (scrollController.position.pixels > nextPageTrigger) {
        homeBloc.add(const GetMoreResultsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.black,
                  bottom: AppBar(
                      toolbarHeight: kToolbarHeight + 10,
                      backgroundColor: Colors.black,
                      automaticallyImplyLeading: false,
                      leading: const SizedBox.shrink(),
                      leadingWidth: 0,
                      centerTitle: true,
                      title: const SearchPokemonField()),
                  expandedHeight: 240.0,
                  floating: true,
                  pinned: true,
                  leading: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 40,
                      )),
                  actions: [
                    Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset(
                          AppImages.avatarImage,
                          height: 50,
                        ))
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 35, right: 20, left: 20),
                        child: Text('Encuentra tu pokemon',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                  ),
                ),
              ];
            },
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: CustomScrollView(slivers: [
                  SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1),
                      delegate: SliverChildBuilderDelegate(
                          (_, index) => Hero(
                              tag: state.searchResults[index].id ?? '',
                              child: PokemonTile(
                                  pokemon: state.searchResults[index],
                                  onSelectPokemon: (pokemon) {
                                    context.read<DetailsBloc>().add(
                                        PickPokemonEvent(
                                            pokemonEntity: pokemon));
                                    AppNavigator.push(Routes.DetailsPage);
                                  },
                                  onUpdateFavorite: (pokemon) {
                                    context.read<HomeBloc>().add(
                                        UpdateFavoritePokemonEvent(
                                            pokemonEntity: pokemon));
                                  })),
                          childCount: state.searchResults.length)),
                  SliverToBoxAdapter(
                    child: Visibility(
                        visible: (state.searchText ?? '').isEmpty,
                        child: const Center(
                          heightFactor: 1,
                          widthFactor: 1,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.8,
                              color: Colors.yellow,
                            ),
                          ),
                        )),
                  )
                ])),
          ),
        ),
      ),
    );
  }
}
