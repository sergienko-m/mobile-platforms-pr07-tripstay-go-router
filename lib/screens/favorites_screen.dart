import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';
import '../models/hotel.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({required this.appState, super.key});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final favorites =
            hotels.where((h) => appState.favoriteIds.contains(h.id)).toList();
        return Scaffold(
          appBar: AppBar(title: const Text('Обране')),
          body: favorites.isEmpty
              ? const Center(child: Text('Додайте готелі в обране'))
              : ListView(
                  children: [
                    for (final h in favorites)
                      ListTile(
                        leading: const Icon(Icons.hotel),
                        title: Text(h.name),
                        subtitle: Text(h.city),
                        onTap: () => context.push('/hotels/${h.id}'),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
