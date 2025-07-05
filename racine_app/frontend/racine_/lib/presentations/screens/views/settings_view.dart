import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _copyId(BuildContext context) {
    const id = 'samsonboss#R';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Identifiant copié : $id")));
    // Tu peux remplacer par Clipboard.setData si tu importes services.dart
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.transparent,
        title: const Text('Racine', style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.pinkAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset("assets/racine-logo.png", width: 40),
            const SizedBox(width: 12),
            const Text(
              "Paramètres",
              style: TextStyle(fontFamily: 'Orbitron', color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            color: Colors.white70,
            onPressed: () {}, // à lier à une page d'infos
          ),
        ],
      ),
      body: */ListView(
        padding: const EdgeInsets.only(
          top: kToolbarHeight + 24,
          left: 16,
          right: 16,
        ),
        children: [
          _buildSection(
            title: "Mon identifiant",
            content: "Identifiant : samsonboss#R",
            buttonText: "Copier l'identifiant",
            onPressed: () => _copyId(context),
          ),
          _buildSection(
            title: "Préférences de confidentialité",
            content:
                "Gérez les plateformes autorisées à voir vos informations personnelles.",
            buttonText: "Gérer les autorisations",
            onPressed: () => _showAlert(
              context,
              "Redirection vers la gestion des autorisations...",
            ),
          ),
          _buildSection(
            title: "Sécurité",
            content:
                "Définissez la durée de vos sessions de connexion ou révoquez des connexions.",
            buttonText: "Paramètres de session",
            onPressed: () => _showAlert(
              context,
              "Redirection vers la gestion des sessions...",
            ),
          ),
          _buildSection(
            title: "Déconnexion",
            content:
                "Vous pouvez vous déconnecter de tous les appareils connectés.",
            buttonText: "Se déconnecter",
            onPressed: () => _showAlert(context, "Déconnecté avec succès"),
          ),
        ],
      );/*,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withOpacity(0.3),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 1) Navigator.pushNamed(context, '/notifications');
          // 2 = settings
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );*/
  }

  Widget _buildSection({
    required String title,
    required String content,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE52C6A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
