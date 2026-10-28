import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuestPickerScreen extends StatefulWidget {
  const GuestPickerScreen({required this.initial, super.key});
  final int initial;
  @override
  State<GuestPickerScreen> createState() => _GuestPickerScreenState();
}

class _GuestPickerScreenState extends State<GuestPickerScreen> {
  late int value;
  @override
  void initState() {
    super.initState();
    value = widget.initial;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Кількість гостей')),
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('$value', style: Theme.of(context).textTheme.displayMedium),
        Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              onPressed: () => setState(() => value = (value - 1).clamp(1, 10)),
              icon: const Icon(Icons.remove_circle_outline)),
          IconButton(
              onPressed: () => setState(() => value = (value + 1).clamp(1, 10)),
              icon: const Icon(Icons.add_circle_outline))
        ]),
        const SizedBox(height: 20),
        FilledButton(
            onPressed: () => context.pop(value),
            child: const Text('Застосувати'))
      ])));
}
