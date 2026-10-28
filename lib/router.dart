import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_state.dart';
import 'models/hotel.dart';
import 'screens/booking_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/guest_picker_screen.dart';
import 'screens/hotel_screen.dart';
import 'screens/login_screen.dart';
import 'screens/room_screen.dart';
import 'screens/search_screen.dart';
import 'screens/trips_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

GoRouter createRouter(AppState appState) {
  String? redirect(BuildContext context, GoRouterState state) {
    final location = state.uri.toString();
    final isBooking = state.uri.path.contains('/book');
    if (isBooking && !appState.isLoggedIn) {
      return '/login?from=${Uri.encodeComponent(location)}';
    }
    if (state.uri.path == '/login' && appState.isLoggedIn) {
      return state.uri.queryParameters['from'] ?? '/hotels';
    }
    return null;
  }

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/hotels',
    refreshListenable: appState,
    redirect: redirect,
    errorBuilder: (context, state) => ErrorScreen(message: state.error?.toString() ?? 'Адресу не знайдено'),
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen(from: state.uri.queryParameters['from'], appState: appState)),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/hotels', builder: (context, state) => SearchScreen(appState: appState, city: state.uri.queryParameters['city'] ?? '', nights: int.tryParse(state.uri.queryParameters['nights'] ?? '') ?? 1), routes: [
              GoRoute(path: ':hotelId', builder: (context, state) => HotelScreen(hotel: _hotel(state.pathParameters['hotelId']!), appState: appState, city: state.uri.queryParameters['city'] ?? '', nights: int.tryParse(state.uri.queryParameters['nights'] ?? '') ?? 1), routes: [
                GoRoute(path: 'rooms/:roomId', builder: (context, state) => RoomScreen(hotel: _hotel(state.pathParameters['hotelId']!), roomId: state.pathParameters['roomId']!, nights: int.tryParse(state.uri.queryParameters['nights'] ?? '') ?? 1)),
                GoRoute(path: 'book', builder: (context, state) => BookingScreen(hotel: _hotel(state.pathParameters['hotelId']!), appState: appState, nights: int.tryParse(state.uri.queryParameters['nights'] ?? '') ?? 1), routes: [
                  GoRoute(path: 'guests', builder: (context, state) => GuestPickerScreen(initial: int.tryParse(state.uri.queryParameters['value'] ?? '') ?? 2)),
                ]),
              ]),
            ]),
          ]),
          StatefulShellBranch(routes: [GoRoute(path: '/trips', builder: (context, state) => TripsScreen(appState: appState))]),
          StatefulShellBranch(routes: [GoRoute(path: '/favorites', builder: (context, state) => FavoritesScreen(appState: appState))]),
        ],
      ),
    ],
  );
}

Hotel _hotel(String id) => hotels.firstWhere((hotel) => hotel.id == id, orElse: () => hotels.first);

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: navigationShell,
    bottomNavigationBar: NavigationBar(selectedIndex: navigationShell.currentIndex, onDestinationSelected: navigationShell.goBranch, destinations: const [
      NavigationDestination(icon: Icon(Icons.search), label: 'Пошук'),
      NavigationDestination(icon: Icon(Icons.luggage), label: 'Поїздки'),
      NavigationDestination(icon: Icon(Icons.favorite), label: 'Обране'),
    ]),
  );
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.message, super.key});
  final String message;
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Помилка навігації')), body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.map_outlined, size: 64), const SizedBox(height: 16), Text(message, textAlign: TextAlign.center), const SizedBox(height: 16), FilledButton(onPressed: () => context.go('/hotels'), child: const Text('На головну'))]))));
}
