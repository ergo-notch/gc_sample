import 'package:flutter/material.dart';
import 'package:sample/features/details/presentation/ui/moves_widget.dart';
import 'package:sample/features/details/presentation/ui/stats_widget.dart';

class DatailsTabView extends StatelessWidget {
  const DatailsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.white,
            dividerColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'Stats',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Tab(
                child: Text(
                  'Moves',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: TabBarView(
              children: [
                StatsWidget(),
                MovesWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
