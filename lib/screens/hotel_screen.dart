import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';
import '../models/hotel.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({
    required this.hotel,
    required this.appState,
    required this.city,
    required this.nights,
    super.key,
  });

  final Hotel hotel;
  final AppState appState;
  final String city;
  final int nights;

  String get _searchCity => city.isEmpty ? hotel.city : city;

  String _bookingPath(int numberOfNights) =>
      '/hotels/${hotel.id}/book?city=${Uri.encodeComponent(_searchCity)}&nights=$numberOfNights';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final isFavorite = appState.favoriteIds.contains(hotel.id);
        return Scaffold(
          appBar: AppBar(
            title: Text(hotel.name),
            actions: [
              IconButton(
                onPressed: () => appState.toggleFavorite(hotel.id),
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.hotel, size: 90, color: Colors.teal),
              ),
              const SizedBox(height: 18),
              Text(hotel.name,
                  style: Theme.of(context).textTheme.headlineSmall),
              Text('${hotel.city} · рейтинг ${hotel.rating}',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Chip(
                  avatar: const Icon(Icons.nights_stay, size: 18),
                  label: Text('Ночей: $nights')),
              const SizedBox(height: 8),
              Text(hotel.description),
              const SizedBox(height: 20),
              Text('Номери', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              for (final room in rooms)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.bed),
                    title: Text(room.name),
                    subtitle: Text('${room.priceFor(hotel)} грн за ніч'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(
                        '/hotels/${hotel.id}/rooms/${room.id}?nights=$nights'),
                  ),
                ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.push(_bookingPath(nights)),
                icon: const Icon(Icons.event_available),
                label: const Text('Забронювати'),
              ),
            ],
          ),
        );
      },
    );
  }
}
