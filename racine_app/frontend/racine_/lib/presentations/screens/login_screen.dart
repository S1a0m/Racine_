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
      backgroundColor: Colors.black, // Full dark
      body: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF2F5F54)),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 255, 192, 0.2),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/racine-logo.png', width: 80),
                const SizedBox(height: 20),
                Text(
                  step == 1
                      ? "Entrer mon identifiant"
                      : "Confirmation par code",
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                if (step == 1) ...[
                  _buildTextField(
                    controller: idController,
                    hint: "ex: samsonboss#R",
                    icon: Icons.alternate_email,
                  ),
                  const SizedBox(height: 20),
                  _buildButton("Confirmer", nextStep),
                ] else ...[
                  const Text(
                    "Un SMS vous a été envoyé. Entrez le code reçu :",
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: codeController,
                    hint: "Code SMS",
                    icon: Icons.message,
                    isNumber: true,
                  ),
                  const SizedBox(height: 20),
                  _buildButton("Vérifier", verifyCode),
                ],

                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text(
                    "Pas encore inscrit ? S'inscrire",
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontFamily: 'Orbitron',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.white54) : null,
        filled: true,
        fillColor: Colors.white10,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF10B981), width: 1),
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE52C6A),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Orbitron',
          fontSize: 14,
        ),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white70)),
    );
  }
}
