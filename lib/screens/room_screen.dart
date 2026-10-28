import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/hotel.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({
    required this.hotel,
    required this.roomId,
    required this.nights,
    super.key,
  });

  final Hotel hotel;
  final String roomId;
  final int nights;

  @override
  Widget build(BuildContext context) {
    final room = rooms.firstWhere((r) => r.id == roomId, orElse: () => rooms.first);
    return Scaffold(
      appBar: AppBar(title: Text(room.name)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.king_bed, size: 72, color: Colors.teal),
            const SizedBox(height: 16),
            Text('${room.name} у готелі ${hotel.name}', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('${hotel.city} · ${room.priceFor(hotel)} грн за ніч'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.push('/hotels/${hotel.id}/book?nights=$nights'),
              child: const Text('Забронювати'),
            ),
          ],
        ),
      ),
    );
  }
}
