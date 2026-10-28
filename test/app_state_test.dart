import 'package:flutter_test/flutter_test.dart';
import 'package:trip_booking_app/app_state.dart';

void main() {
  test('app state stores favorites and trips', () {
    final state = AppState();
    state.toggleFavorite('kyiv-center');
    state.addTrip('kyiv-center');
    expect(state.favoriteIds, contains('kyiv-center'));
    expect(state.trips, contains('kyiv-center'));
  });

  test('login notifies and stores user', () {
    final state = AppState();
    state.login('Олена');
    expect(state.isLoggedIn, isTrue);
    expect(state.userName, 'Олена');
  });
}
