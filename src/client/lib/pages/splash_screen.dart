// splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saras_faqs/utils/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282b),
      body: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          width: screenWidth(context) * 0.5,
        ),
      ),
    );
  }
}