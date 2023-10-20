import 'package:flutter/material.dart';
import 'package:prohour_assignment/Pages/Display.dart';
import 'package:prohour_assignment/Pages/Home.dart';
import 'package:prohour_assignment/Pages/SplashScreen.dart';
import 'package:provider/provider.dart';

import 'Provider/NumberCheckingProvider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  NumberProvider()),

      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,

        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => Home(),
        },

        ),
    );


  }
}


