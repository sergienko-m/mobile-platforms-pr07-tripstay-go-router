import 'package:flutter/material.dart';
import 'app_state.dart';
import 'router.dart';

void main() {
  final appState = AppState();
  runApp(TripBookingApp(appState: appState));
}

class TripBookingApp extends StatelessWidget {
  const TripBookingApp({required this.appState, super.key});
  final AppState appState;
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'TripStay',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff176b87)), useMaterial3: true, scaffoldBackgroundColor: const Color(0xfff5f8fa)),
    routerConfig: createRouter(appState),
  );
}
