import 'package:flutter/material.dart';

import '../models/hotel.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({required this.hotel, required this.roomId, super.key});

  final Hotel hotel;
  final String roomId;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Номер $roomId')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.king_bed, size: 72, color: Colors.teal),
            const SizedBox(height: 16),
            Text('Номер у готелі ${hotel.name}', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Комфортний номер для проживання у місті ${hotel.city}.'),
          ]),
        ),
      );
}
