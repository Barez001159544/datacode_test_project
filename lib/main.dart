// import 'package:datacode_interview/currency_display_page.dart';
// import 'package:datacode_interview/get_currency_exchange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// import 'crypto_screen.dart';
// import 'events_and_states.dart';
import 'home_pagee.dart';


void main() {
  runApp(const HomePage());
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final channel = WebSocketChannel.connect(
//     Uri.parse('wss://ws.kraken.com'),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CryptoBloc(),
//       child: MaterialApp(
//         title: 'Crypto Price Tracker',
//         initialRoute: '/',
//         routes: {
//           '/': (context) => HomePage(),
//           '/crypto': (context) => CryptoScreen(crypto: '',),
//         },
//       ),
//     );
//   }
// }
