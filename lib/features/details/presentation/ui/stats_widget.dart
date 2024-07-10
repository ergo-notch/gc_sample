import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/core/utils/extensions.dart';
import 'package:sample/features/details/presentation/bloc/details_bloc.dart';
import 'package:sample/features/details/presentation/bloc/details_state.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (_, detailsState) {
        return Card(
            color: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: detailsState.pokemonDetails?.stats
                          ?.map((stat) => Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            (stat.name ?? '').capitalize(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            stat.baseStat.toString(),
                                            style: TextStyle(
                                              color: Colors.yellow.shade300,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: LinearProgressIndicator(
                                            minHeight: 12,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            value: (stat.baseStat ?? 0) / 100,
                                            backgroundColor: Colors.grey,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.yellow.shade300)))
                                  ],
                                ),
                              ))
                          .toList() ??
                      const <Widget>[],
                )));
      },
    );
  }
}
