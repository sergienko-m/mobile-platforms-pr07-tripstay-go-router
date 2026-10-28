import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool isLoggedIn = false;
  String? userName;
  final Set<String> favoriteIds = <String>{};
  final List<String> trips = <String>[];

  void login(String name) {
    isLoggedIn = true;
    userName = name;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    userName = null;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    favoriteIds.contains(id) ? favoriteIds.remove(id) : favoriteIds.add(id);
    notifyListeners();
  }

  void addTrip(String id) {
    if (!trips.contains(id)) trips.add(id);
    notifyListeners();
  }
}
