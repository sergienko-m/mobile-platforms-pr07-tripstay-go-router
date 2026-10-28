import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_state.dart';import '../models/hotel.dart';
class FavoritesScreen extends StatelessWidget{const FavoritesScreen({required this.appState,super.key});final AppState appState;@override Widget build(BuildContext context){final fav=hotels.where((h)=>appState.favoriteIds.contains(h.id)).toList();return Scaffold(appBar:AppBar(title:const Text('Обране')),body:fav.isEmpty?const Center(child:Text('Додайте готелі в обране')):ListView(children:fav.map((h)=>ListTile(leading:const Icon(Icons.hotel),title:Text(h.name),subtitle:Text(h.city),onTap:()=>context.push('/hotels/${h.id}'))).toList()));}}
