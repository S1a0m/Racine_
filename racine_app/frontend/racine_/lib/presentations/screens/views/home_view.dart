import 'package:flutter/material.dart';
import 'package:racine/presentations/screens/app_details_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  bool showId = true;
  bool isAppSelected = true;
  bool showSearchForm = false;
  int selectedIndex = 0;
  bool isVerified = true;

  late AnimationController _pulseController;
  late Animation<double> _opacityAnimation;

  final List<Map<String, dynamic>> apps = [
    {
      'name': 'LearnAfrik',
      'details': 'Connecté depuis le 10 juin 2025',
      'hasNew': true,
      'icon': 'assets/racine-logo.png',
    },
    {
      'name': 'YonnApp Forum',
      'details': 'Connexion anonyme acceptée',
      'hasNew': false,
      'icon': 'assets/racine-logo.png',
    },
    {
      'name': 'Tôswè e-commerce',
      'details': 'Dernière connexion : 27 juin 2025',
      'hasNew': false,
      'icon': 'assets/racine-logo.png',
    },
    {
      'name': 'Génie Auth',
      'details': 'Connecté en tant qu’anonyme',
      'hasNew': false,
      'icon': 'assets/racine-logo.png',
    },
    {
      'name': 'LearnAfrik',
      'details': 'Connecté depuis le 10 juin 2025',
      'hasNew': true,
      'icon': 'assets/racine-logo.png',
    },
    {
      'name': 'YonnApp Forum',
      'details': 'Connexion anonyme acceptée',
      'hasNew': true,
      'icon': 'assets/racine-logo.png',
    },
    {
      'name': 'Tôswè e-commerce',
      'details': 'Dernière connexion : 27 juin 2025',
      'hasNew': true,
      'icon': 'assets/racine-logo.png',
    },
    {
      'name': 'Génie Auth',
      'details': 'Connecté en tant qu’anonyme',
      'hasNew': false,
      'icon': 'assets/racine-logo.png',
    },
  ];

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
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profil utilisateur
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
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 20,
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
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
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
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
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
                  const SizedBox(width: 12),
                  Expanded(
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
                        const SizedBox(height: 4),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Text(
                            showId ? 'samsonboss#R' : '••••••••',
                            key: ValueKey(showId),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
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
            ),
          ),

          // le reste ne change pas...
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
                onPressed: (index) => setState(() => selectedIndex = index),
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
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: apps.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final app = apps[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppDetailsScreen(),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Stack(
                      children: [
                        // Logo en fond
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.2, //0.05,
                            child: Image.asset(app['icon'], fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '#R',
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                app['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                app['details'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white60,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.more_horiz, color: Colors.white54),

                                  /*const Text(
                                    '• • •',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white30,
                                    ),
                                  )*/
                                  if (app['hasNew'])
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.pinkAccent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: const [
                                          Text(
                                            'new',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(
                                            Icons.notifications_active,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
