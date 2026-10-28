import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/hotel.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({required this.appState, super.key});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final upcoming =
            hotels.where((h) => appState.trips.contains(h.id)).toList();
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Поїздки'),
              bottom: const TabBar(
                  tabs: [Tab(text: 'Майбутні'), Tab(text: 'Минулі')]),
            ),
            body: TabBarView(
              children: [
                upcoming.isEmpty
                    ? const Center(child: Text('Майбутніх поїздок немає'))
                    : ListView(
                        children: [
                          for (final h in upcoming)
                            ListTile(
                                leading: const Icon(Icons.luggage),
                                title: Text(h.name),
                                subtitle: Text(h.city)),
                        ],
                      ),
                const Center(child: Text('Минулі поїздки з’являться тут')),
              ],
            ),
          ),
        );
      },
    );
  }
}
