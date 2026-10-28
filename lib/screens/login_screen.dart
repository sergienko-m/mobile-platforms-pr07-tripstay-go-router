import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_state.dart';
class LoginScreen extends StatefulWidget { const LoginScreen({required this.from,required this.appState,super.key}); final String? from; final AppState appState; @override State<LoginScreen> createState()=>_LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen>{final name=TextEditingController(text:'Олена');@override void dispose(){name.dispose();super.dispose();}void _login(){widget.appState.login(name.text);final destination=widget.from==null?'/hotels':Uri.decodeComponent(widget.from!);context.go(destination);}@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Вхід')),body:Padding(padding:const EdgeInsets.all(24),child:Column(children:[const Icon(Icons.account_circle,size:82),const SizedBox(height:16),TextField(controller:name,decoration:const InputDecoration(labelText:'Ваше ім’я',border:OutlineInputBorder())),const SizedBox(height:20),FilledButton.icon(onPressed:_login,icon:const Icon(Icons.login),label:const Text('Увійти'))])));}
}
