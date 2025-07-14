import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDetailsScreen extends StatelessWidget {
  const AppDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white70,
        title: Text("AppName", style: const TextStyle(fontFamily: 'Orbitron')),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () async {
              const url = "https://example.com";
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
            tooltip: "Visiter la plateforme",
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionHeader("Identité de la plateforme"),
          _infoTile("Identifiant Racine", "ApppId"),
          _infoTile("Type", "Application mobile"),

          const Divider(color: Colors.white24, height: 32),

          _sectionHeader("Historique de connexion"),
          _infoTile("Dernière connexion", "27 juin 2025 à 18:42"),
          _infoTile("Méthode de connexion", "Identifiant Racine"),

          const Divider(color: Colors.white24, height: 32),

          _sectionHeader("Autorisations accordées"),
          _permissionTile("Accès à l'email", true, context),
          _permissionTile("Utilisation de la localisation", true, context),
          _permissionTile(
            "Publication au nom de l'utilisateur",
            false,
            context,
          ),

          const Divider(color: Colors.white24, height: 32),

          _sectionHeader("Visibilité & confidentialité"),
          _infoTile("Connexion visible publiquement", "Non"),
          _infoTile("Statut de la connexion", "Actif"),

          const Divider(color: Colors.white24, height: 32),

          _sectionHeader("Actions"),
          ElevatedButton.icon(
            icon: const Icon(Icons.cancel),
            label: const Text(
              "Révoquer les autorisations",
              style: TextStyle(color: Colors.white70),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            onPressed: () {},
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Afficher l'historique complet des connexions"),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.white70),
            label: const Text("Se déconnecter de cette plateforme"),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.pinkAccent),
              foregroundColor: Colors.white70,
            ),
          ),

          const Divider(color: Colors.white24, height: 32),

          _sectionHeader("Traçabilité"),
          _infoTile("ID de trace", "trace_43jkd_#R"),
          _infoTile("Première connexion", "10 juin 2025"),
          _infoTile("Jeton d'accès valide jusqu'à", "10 août 2025"),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      title: Text(label, style: const TextStyle(color: Colors.white70)),
      subtitle: Text(value, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _permissionTile(
    String permission,
    bool granted,
    BuildContext context,
  ) {
    return SwitchListTile(
      title: Text(permission, style: const TextStyle(color: Colors.white70)),
      value: granted,
      activeColor: Colors.pinkAccent,
      onChanged: (val) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Modification',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              val ? "Autorisation activée" : "Autorisation révoquée",
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
