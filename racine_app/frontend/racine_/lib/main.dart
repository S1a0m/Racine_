import 'package:flutter/material.dart';
import 'package:racine/presentations/routes/racine_routes.dart';

void main() {
  runApp(const RacineApp());
}

class RacineApp extends StatelessWidget {
  const RacineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Racine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Orbitron',
        //scaffoldBackgroundColor: Colors.black.withOpacity(0.3), //const Color(0xFF133D36),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.pinkAccent,
          secondary: Colors.white,
        ),
      ),
      initialRoute: "/splash",
      //initialRoute: RacineRoutes.initial,
      routes: RacineRoutes.routes,
    );
  }
}
