// main.dart

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import the splash screen file
import 'screens/currentChangePinScreen.dart';
import 'screens/changePinConfirmationScreen.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home:
          ChangePinConfirmationScreen(), // Set the SplashScreen widget as home
    );
  }
}
