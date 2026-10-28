import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';
import '../models/hotel.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    required this.hotel,
    required this.appState,
    required this.nights,
    super.key,
  });

  final Hotel hotel;
  final AppState appState;
  final int nights;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _guests = 2;
  bool _agreed = false;
  bool _changed = false;

  Future<void> _pickGuests() async {
    final result = await context
        .push<int>('/hotels/${widget.hotel.id}/book/guests?value=$_guests');
    if (!mounted) return;
    if (result != null) {
      setState(() {
        _guests = result;
        _changed = true;
      });
    }
  }

  void _confirm() {
    widget.appState.addTrip(widget.hotel.id);
    setState(() => _changed = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Бронювання збережено')));
  }

  Future<void> _onPopInvoked(bool didPop, Object? result) async {
    if (didPop) return;
    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Вийти без збереження?'),
        content: const Text('Введені дані буде втрачено.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Залишитися')),
          FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Вийти')),
        ],
      ),
    );
    if (leave == true && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_changed,
      onPopInvokedWithResult: _onPopInvoked,
      child: Scaffold(
        appBar: AppBar(title: const Text('Бронювання')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(widget.hotel.name,
                style: Theme.of(context).textTheme.headlineSmall),
            Text(
                'Ночей: ${widget.nights} · ${widget.hotel.price * widget.nights} грн'),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: Text('Гості: $_guests'),
                trailing: TextButton(
                    onPressed: _pickGuests, child: const Text('Змінити')),
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Ім’я гостя', border: OutlineInputBorder()),
              onChanged: (_) => setState(() => _changed = true),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _agreed,
              onChanged: (value) => setState(() {
                _agreed = value ?? false;
                _changed = true;
              }),
              title: const Text('Погоджуюсь з умовами бронювання'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _agreed ? _confirm : null,
              child: const Text('Підтвердити бронювання'),
            ),
          ],
        ),
      ),
    );
  }
}
