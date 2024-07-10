import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/core/utils/extensions.dart';
import 'package:sample/features/details/presentation/bloc/details_bloc.dart';
import 'package:sample/features/details/presentation/bloc/details_state.dart';

class MovesWidget extends StatelessWidget {
  const MovesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(builder: (_, state) {
      Widget moveWidget(String name) {
        return Chip(
          color: WidgetStateProperty.all(Colors.black.withOpacity(0.8)),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
          label: Text(name.capitalize()),
        );
      }

      List<Widget> createGridView() {
        return state.pokemonDetails?.moves
                ?.map((move) => moveWidget(move.name))
                .toList() ??
            [];
      }

      return Card(
          color: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 18.0,
              runSpacing: 7.0,
              children: createGridView(),
            ),
          ));
    });
  }
}
