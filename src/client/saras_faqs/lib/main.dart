// main.dart

import 'package:flutter/material.dart';
import 'package:saras_faqs/pages/faqs_home_page.dart';
import 'package:saras_faqs/pages/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const SplashScreen(),
        "/home": (context) => const HomePage(),
      },
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}