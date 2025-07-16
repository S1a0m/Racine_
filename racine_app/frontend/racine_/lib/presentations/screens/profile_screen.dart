import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool showId = true;
  bool isPublic = true;
  bool isVerified = true;

  late AnimationController _pulseController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _opacityAnimation = Tween(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white70,
        elevation: 0,
        title: const Text(
          'Profile : Particulier',
          style: TextStyle(fontFamily: 'Orbitron'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
            tooltip: "Paramètres",
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
        children: [
          _buildIdentityCard(),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/entitiesform');
              },
              label: Text('Voir plus'),
              icon: Icon(Icons.person_2_outlined),
            ),
          ),
          const SizedBox(height: 20),
          _buildStatsSection(),
          const SizedBox(height: 20),
          _buildConnectionsSection(),
          /*const SizedBox(height: 20),
          _buildSecuritySettings(),*/
          const SizedBox(height: 20),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildIdentityCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2F5F54)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 255, 192, 0.2),
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: isVerified
                    ? FadeTransition(
                        opacity: _opacityAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: const Icon(
                          Icons.cancel,
                          size: 14,
                          color: Colors.redAccent,
                        ),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Samson AMOUSSOU',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showId ? 'samsonboss#R' : '••••••••',
                style: const TextStyle(color: Colors.white70),
              ),
              IconButton(
                icon: Icon(
                  showId ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: () => setState(() => showId = !showId),
              ),
            ],
          ),
          /*Text(
            'Identifiant particulier',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),*/
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return _buildCard(
      title: 'Statistiques',
      child: Column(
        children: const [
          _StatTile(label: 'Connexions actives', value: '3'),
          _StatTile(label: 'Dernière activité', value: '27 juin 2025'),
          _StatTile(label: 'Révocations', value: '1'),
        ],
      ),
    );
  }

  Widget _buildConnectionsSection() {
    final connections = [
      {'name': 'LearnAfrik', 'details': 'Connecté depuis le 10 juin 2025'},
      {'name': 'YonnApp Forum', 'details': 'Connexion anonyme acceptée'},
      {
        'name': 'Tôswè e-commerce',
        'details': 'Dernière connexion : 27 juin 2025',
      },
    ];
    return _buildCard(
      title: 'Connexions actives',
      child: Column(
        children: connections.map((app) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/racine-logo.png'),
              backgroundColor: Colors.white10,
            ),
            title: Text(
              app['name']!,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              app['details']!,
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel_outlined, color: Colors.redAccent),
              onPressed: () {},
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return _buildCard(
      title: 'Paramètres & sécurité',
      child: ListTile(
        title: const Text(
          'Accéder aux paramètres',
          style: TextStyle(color: Colors.white),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
        onTap: () {},
      ) /*Column(
        children: [
          SwitchListTile(
            value: isPublic,
            onChanged: (v) => setState(() => isPublic = v),
            title: const Text(
              'Profil public',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Rendre mon identifiant visible à tous',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ListTile(
            title: const Text(
              'Activer la double authentification',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.white54),
            onTap: () {},
          ),
        ],
      ),*/,
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout, color: Colors.white70),
          label: const Text(
            'Se déconnecter',
            style: TextStyle(color: Colors.white70),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
        ),
        /*const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Supprimer mon compte',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),*/
      ],
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
