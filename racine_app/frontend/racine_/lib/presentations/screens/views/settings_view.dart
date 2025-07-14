import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _copyId(BuildContext context) {
    const id = 'samsonboss#R';
    Clipboard.setData(const ClipboardData(text: id));
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Identifiant copié : samsonboss#R")),
    );
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text('Racine', style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.pinkAccent)),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text(
          "Confirmation",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Voulez-vous vraiment vous déconnecter ?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showAlert(context, "Déconnecté avec succès");
            },
            child: const Text(
              "Se déconnecter",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        children: [
          _buildSection(
            icon: Icons.fingerprint,
            title: "Mon identifiant",
            content: "Identifiant : samsonboss#R",
            buttonText: "Copier l'identifiant",
            onPressed: () => _copyId(context),
          ),
          _buildSection(
            icon: Icons.privacy_tip,
            title: "Confidentialité",
            content:
                "Gérez les plateformes autorisées à voir vos informations personnelles.",
            buttonText: "Gérer les autorisations",
            onPressed: () => _showAlert(
              context,
              "Redirection vers la gestion des autorisations...",
            ),
          ),
          _buildSection(
            icon: Icons.security,
            title: "Sécurité",
            content:
                "Définissez la durée de vos sessions ou révoquez des connexions.",
            buttonText: "Paramètres de session",
            onPressed: () => _showAlert(
              context,
              "Redirection vers la gestion des sessions...",
            ),
          ),
          _buildSection(
            icon: Icons.logout,
            title: "Déconnexion",
            content:
                "Vous pouvez vous déconnecter de tous les appareils connectés.",
            buttonText: "Se déconnecter",
            onPressed: () => _confirmLogout(context),
          ),
          const SizedBox(height: 16),
          _buildSection(
            icon: Icons.info_outline,
            title: "À propos",
            content:
                "Racine est une solution d'identité numérique développée par WaKiOWa.\nContact : contact@wakowa.africa",
            buttonText: "Nous contacter",
            onPressed: () => _showAlert(context, "contact@wakowa.africa"),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE52C6A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
