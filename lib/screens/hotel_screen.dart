import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_state.dart';
import '../models/hotel.dart';
class HotelScreen extends StatelessWidget {
  const HotelScreen({required this.hotel, required this.appState, required this.city, required this.nights, super.key}); final Hotel hotel; final AppState appState; final String city; final int nights;
  String _bookingPath(int numberOfNights) => '/hotels/${hotel.id}/book?city=${Uri.encodeComponent(city.isEmpty ? hotel.city : city)}&nights=$numberOfNights';
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text(hotel.name),actions:[IconButton(onPressed:()=>appState.toggleFavorite(hotel.id),icon:Icon(appState.favoriteIds.contains(hotel.id)?Icons.favorite:Icons.favorite_border))]),body:ListView(padding:const EdgeInsets.all(20),children:[Container(height:180,decoration:BoxDecoration(color:Colors.teal.shade50,borderRadius:BorderRadius.circular(20)),child:const Icon(Icons.hotel,size:90,color:Colors.teal)),const SizedBox(height:18),Text(hotel.name,style:Theme.of(context).textTheme.headlineSmall),Text('${hotel.city} · рейтинг ${hotel.rating}',style:Theme.of(context).textTheme.titleMedium),const SizedBox(height:12),Text(hotel.description),const SizedBox(height:24),Card(child:ListTile(leading:const Icon(Icons.bed),title:const Text('Стандартний номер'),subtitle:Text('${hotel.price} грн за ніч'),trailing:FilledButton(onPressed:()=>context.push(_bookingPath(nights)),child:const Text('Забронювати')))),const SizedBox(height:12),OutlinedButton.icon(onPressed:()=>context.push(_bookingPath(3)),icon:const Icon(Icons.calendar_month),label:const Text('Забронювати на 3 ночі'))]));
}
