import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int step = 1;
  final TextEditingController idController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  void nextStep() {
    final id = idController.text.trim();
    if (!id.endsWith('#R')) {
      showError("L'identifiant doit se terminer par #R");
    } else {
      setState(() => step = 2);
    }
  }

  void verifyCode() {
    if (codeController.text.trim() == "123456") {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      showError("Code incorrect. Réessayez.");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(message, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFF2F5F54)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 255, 192, 0.2),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/racine-logo.png', width: 80),
                const SizedBox(height: 16),
                Text(
                  step == 1
                      ? 'Entrer mon identifiant'
                      : 'Confirmation par code',
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                if (step == 1) ...[
                  TextField(
                    controller: idController,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration("ex: samsonboss#R"),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: nextStep,
                    style: _buttonStyle(),
                    child: const Text(
                      "Confirmer",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ] else ...[
                  const Text(
                    "Un SMS vous a été envoyé. Entrez le code reçu :",
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: codeController,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration("Code SMS"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: verifyCode,
                    style: _buttonStyle(),
                    child: const Text(
                      "Confirmer",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text(
                    "Pas encore inscrit ? S'inscrire",
                    style: TextStyle(color: Color(0xFF10B981)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white10,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFE52C6A),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Orbitron',
      ),
    );
  }
}
