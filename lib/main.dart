import 'package:flutter/material.dart';
import 'package:clea/theme.dart';
import 'package:clea/screens/welcome_screen.dart';
import 'package:clea/screens/onboarding_screen.dart';
import 'package:clea/screens/user_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cléa - Découvre ton rang patrimonial',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreenSimple(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/user-form': (context) => const UserFormScreen(),
      },
    );
  }
}

