import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_state.dart';
import '../models/hotel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {required this.appState,
      required this.city,
      required this.nights,
      super.key});
  final AppState appState;
  final String city;
  final int nights;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _cityController;
  late int _nights;
  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: widget.city);
    _nights = widget.nights;
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _search() {
    final city = Uri.encodeComponent(_cityController.text.trim());
    context.go('/hotels?city=$city&nights=$_nights');
  }

  @override
  Widget build(BuildContext context) {
    final filtered = hotels
        .where((h) =>
            widget.city.isEmpty ||
            h.city.toLowerCase().contains(widget.city.toLowerCase()))
        .toList();
    return Scaffold(
        appBar: AppBar(title: const Text('Пошук житла'), actions: [
          IconButton(onPressed: _search, icon: const Icon(Icons.refresh))
        ]),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                  labelText: 'Місто',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder()),
              onSubmitted: (_) => _search()),
          const SizedBox(height: 12),
          Row(children: [
            const Text('Ночей:'),
            const SizedBox(width: 12),
            DropdownButton<int>(
                value: _nights.clamp(1, 14),
                items: List.generate(
                    14,
                    (i) => DropdownMenuItem(
                        value: i + 1, child: Text('${i + 1}'))),
                onChanged: (value) {
                  if (value != null) setState(() => _nights = value);
                }),
            const Spacer(),
            FilledButton.icon(
                onPressed: _search,
                icon: const Icon(Icons.search),
                label: const Text('Знайти'))
          ]),
          const SizedBox(height: 18),
          Text(
              widget.city.isEmpty
                  ? 'Популярні варіанти'
                  : 'Результати для «${widget.city}»',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (filtered.isEmpty)
            const Card(
                child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Готелів не знайдено. Спробуйте інше місто.'))),
          ...filtered.map((hotel) => _HotelTile(
              hotel: hotel, nights: _nights, appState: widget.appState)),
        ]));
  }
}

class _HotelTile extends StatelessWidget {
  const _HotelTile(
      {required this.hotel, required this.nights, required this.appState});
  final Hotel hotel;
  final int nights;
  final AppState appState;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
      listenable: appState,
      builder: (context, _) => Card(
          child: InkWell(
              onTap: () => context.push(
                  '/hotels/${hotel.id}?city=${Uri.encodeComponent(hotel.city)}&nights=$nights'),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(children: [
                    Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.hotel, size: 42)),
                    const SizedBox(width: 14),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(hotel.name,
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(hotel.city),
                          Row(children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                            Text(' ${hotel.rating}')
                          ]),
                          Text('${hotel.price} грн / ніч',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    IconButton(
                        onPressed: () => appState.toggleFavorite(hotel.id),
                        icon: Icon(
                            appState.favoriteIds.contains(hotel.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red))
                  ])))));
}
