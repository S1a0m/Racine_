import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String displayedText = '';
  final String fullText = 'Racine';
  int index = 0;
  bool showUnderscore = true;

  Timer? typingTimer;
  Timer? blinkingTimer;

  @override
  void initState() {
    super.initState();
    _startTyping();
    _startCursorBlinking();
  }

  void _startTyping() {
    typingTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (!mounted) return;

      if (index < fullText.length) {
        setState(() {
          displayedText += fullText[index];
          index++;
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
      }
    });
  }

  void _startCursorBlinking() {
    blinkingTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) return;

      setState(() {
        showUnderscore = !showUnderscore;
      });
    });
  }

  @override
  void dispose() {
    typingTimer?.cancel();
    blinkingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/racine-logo.png',
              width: 100,
              height: 100,
              color: Colors.white70,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  displayedText,
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AnimatedOpacity(
                  opacity: showUnderscore ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Text(
                    '_',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Votre gardien numérique.",
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 14,
                color: Colors.white60,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
