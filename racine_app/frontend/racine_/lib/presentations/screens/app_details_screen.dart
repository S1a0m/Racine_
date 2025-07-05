import 'package:flutter/material.dart';

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
            onPressed: () {},
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

          const SizedBox(height: 20),
          _sectionHeader("Historique de connexion"),
          _infoTile("Dernière connexion", "27 juin 2025 à 18:42"),
          _infoTile("Méthode de connexion", "Identifiant Racine"),

          const SizedBox(height: 20),
          _sectionHeader("Autorisations accordées"),
          _permissionTile("Accès à l'email", true),
          _permissionTile("Utilisation de la localisation", true),
          _permissionTile("Publication au nom de l'utilisateur", false),

          const SizedBox(height: 20),
          _sectionHeader("Visibilité & confidentialité"),
          _infoTile("Connexion visible publiquement", "Non"),
          _infoTile("Statut de la connexion", "Actif"),

          const SizedBox(height: 20),
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

          const SizedBox(height: 20),
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
      title: Text(label, style: const TextStyle(color: Colors.white70)),
      subtitle: Text(value, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _permissionTile(String permission, bool granted) {
    return SwitchListTile(
      title: Text(permission, style: const TextStyle(color: Colors.white70)),
      value: granted,
      activeColor: Colors.pinkAccent,
      onChanged: (val) {},
    );
  }
}
