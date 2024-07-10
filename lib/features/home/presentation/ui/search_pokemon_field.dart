import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/features/home/presentation/bloc/home_events.dart';

import '../bloc/home_bloc.dart';

class SearchPokemonField extends StatefulWidget {
  const SearchPokemonField({super.key});

  @override
  SearchPokemonFieldState createState() => SearchPokemonFieldState();
}

class SearchPokemonFieldState extends State<SearchPokemonField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => ());
      final homeBloc = context.read<HomeBloc>();
      _controller.text.isNotEmpty
          ? homeBloc.add(UpdateSearchTextEvent(searchText: _controller.text))
          : homeBloc.add(const ClearSearchTextEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
            size: 30,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[400]),
                  onPressed: () {
                    _controller.clear();
                    homeBloc.add(const ClearSearchTextEvent());
                  },
                )
              : null,
          hintText: 'Buscar',
          alignLabelWithHint: true,
          isDense: true,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 20));
  }
}
