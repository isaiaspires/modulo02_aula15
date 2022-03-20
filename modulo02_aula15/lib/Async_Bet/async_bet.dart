import 'package:flutter/material.dart';
import 'package:modulo02_aula15/Async_Bet/async_bet_screen.dart';

class AsyncBetApp extends StatelessWidget {
  const AsyncBetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AsyncBetScreen(),
    );
  }
}
