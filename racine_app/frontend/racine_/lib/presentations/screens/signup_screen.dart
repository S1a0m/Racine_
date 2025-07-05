import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int step = 1;

  final phoneController = TextEditingController();
  final codeController = TextEditingController();
  final idController = TextEditingController();
  String selectedCode = "+229";

  final List<String> existingNumbers = ["+22999112233", "+2250700112233"];
  final List<String> existingIds = ["samsonboss#R", "toswe#R"];

  String? errorMessage;

  void verifyPhone() {
    final fullPhone = selectedCode + phoneController.text.trim();
    if (existingNumbers.contains(fullPhone)) {
      setState(() => errorMessage = "⚠️ Ce numéro est déjà enregistré.");
    } else if (phoneController.text.length < 6) {
      setState(() => errorMessage = "Veuillez entrer un numéro valide.");
    } else {
      setState(() {
        errorMessage = null;
        step = 2;
      });
    }
  }

  void verifySMS() {
    if (codeController.text.trim() == "123456") {
      setState(() => step = 3);
    } else {
      _showAlert("Code incorrect. Réessayez.");
    }
  }

  void finalizeId() {
    final id = idController.text.trim();
    if ((!id.endsWith(
      '#R',
    )) /*!RegExp(r'^[a-zA-Z0-9_-]+#R\$').hasMatch(id)*/ ) {
      _showAlert("L'identifiant doit se terminer par #R.");
    } else if (existingIds.contains(id)) {
      _showAlert("Cet identifiant est déjà utilisé.");
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  void _showAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.redAccent, content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(24),
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
                    if (step == 1) _buildStep1(),
                    if (step == 2) _buildStep2(),
                    if (step == 3) _buildStep3(),
                    const SizedBox(height: 16),
                    if (step != 4)
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: const Text(
                          "Déjà inscrit ? Se connecter",
                          style: TextStyle(color: Color(0xFF10B981)),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white12),
              const SizedBox(height: 12),
              const Text(
                "© 2025 Racine — une initiative de WaKiOWa",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 4),
              const Text(
                "Contact : support@wakiowa.africa",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      children: [
        const Text(
          "Vérification téléphone",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          dropdownColor: Colors.black87,
          value: selectedCode,
          decoration: _inputDecoration("Indicatif"),
          style: const TextStyle(color: Colors.white),
          items: const [
            DropdownMenuItem(value: "+229", child: Text("🇧🇯 +229 (Bénin)")),
            DropdownMenuItem(
              value: "+225",
              child: Text("🇨🇮 +225 (Côte d’Ivoire)"),
            ),
            DropdownMenuItem(
              value: "+237",
              child: Text("🇨🇲 +237 (Cameroun)"),
            ),
          ],
          onChanged: (val) => setState(() => selectedCode = val!),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Numéro de téléphone"),
        ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Color(0xFFFF8A8A)),
            ),
          ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: verifyPhone,
          style: _buttonStyle(),
          child: const Text("Valider", style: TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      children: [
        const Text(
          "Confirmation par code",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Un SMS vous a été envoyé. Entrez le code reçu :",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: codeController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Code SMS"),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: verifySMS,
          style: _buttonStyle(),
          child: const Text(
            "Confirmer",
            style: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => setState(() => step = 1),
          child: const Text(
            "← Retour",
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      children: [
        const Text(
          "Créer mon identifiant",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: idController,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("ex: samsonboss#R"),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: finalizeId,
          style: _buttonStyle(),
          child: const Text(
            "Créer mon identifiant",
            style: TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => setState(() => step = 2),
          child: const Text(
            "← Retour",
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
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
