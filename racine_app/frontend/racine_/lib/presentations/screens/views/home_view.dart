import 'package:flutter/material.dart';
import 'package:racine/presentations/screens/app_details_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool showId = true;
  bool isAppSelected = true;
  bool showSearchForm = false;
  int selectedIndex = 0;

  final List<Map<String, String>> apps = [
    {'name': 'LearnAfrik', 'details': 'Connecté depuis le 10 juin 2025'},
    {'name': 'YonnApp Forum', 'details': 'Connexion anonyme acceptée'},
    {
      'name': 'Tôswè e-commerce',
      'details': 'Dernière connexion : 27 juin 2025',
    },
    {'name': 'YonnApp Forum', 'details': 'Connexion anonyme acceptée'},
    {
      'name': 'Tôswè e-commerce',
      'details': 'Dernière connexion : 27 juin 2025',
    },
    {'name': 'LearnAfrik', 'details': 'Connecté depuis le 10 juin 2025'},
    {
      'name': 'Tôswè e-commerce',
      'details': 'Dernière connexion : 27 juin 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2F5F54)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 255, 192, 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Samson AMOUSSOU",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/profile.png'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          showId ? 'samsonboss#R' : '••••••••',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          showId ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            showId = !showId;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ToggleButtons(
                borderColor: Colors.white24,
                selectedColor: Colors.pinkAccent,
                fillColor: Colors.white10,
                borderRadius: BorderRadius.circular(10),
                isSelected: [
                  selectedIndex == 0,
                  selectedIndex == 1,
                  selectedIndex == 2,
                ],
                onPressed: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Tout'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Apps'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Sites web'),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  showSearchForm ? Icons.close : Icons.search,
                  color: Colors.white,
                ),
                onPressed: () =>
                    setState(() => showSearchForm = !showSearchForm),
              ),
            ],
          ),
          if (showSearchForm)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Orbitron',
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2a524b).withOpacity(0.2),
                  hintText: 'Rechercher une application...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                  child: Card(
                    color: Colors.white.withOpacity(0.05),
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/racine-logo.png'),
                        backgroundColor: Colors.white10,
                      ),
                      title: Text(
                        app['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        app['details']!,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.white54,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const AppDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
