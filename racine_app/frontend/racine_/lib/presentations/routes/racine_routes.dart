import 'package:flutter/material.dart';
import 'package:racine/presentations/screens/app_details_screen.dart';
//import 'package:racine/presentations/screens/entities_form_screen.dart';
import 'package:racine/presentations/screens/signup_screen.dart';
import 'package:racine/presentations/screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';

class RacineRoutes {
  static const String initial = '/splash';

  static final Map<String, WidgetBuilder> routes = {
    '/splash': (_) => const SplashScreen(),
    '/': (_) => const HomeScreen(),
    '/profile': (_) => const ProfileScreen(),
    '/login': (_) => const LoginScreen(),
    '/signup': (_) => const SignupScreen(),
    '/detailapp': (_) => const AppDetailsScreen(),
    //'/entitiesform': (_) => FormulaireApp(),
  };
}
