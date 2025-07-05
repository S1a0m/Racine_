import 'package:flutter/material.dart';
import './views/notifications_view.dart';
import './views/home_view.dart';
import './views/settings_view.dart';
// import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final Color primaryColor = Colors.white;
  final Color activeColor = Colors.pinkAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(context),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _getSelectedView(_selectedIndex),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _getSelectedView(int index) {
    switch (index) {
      case 0:
        return const HomeView(key: ValueKey('home'));
      case 1:
        return NotificationsView(key: ValueKey('notifications'));
      case 2:
        return const SettingsView(key: ValueKey('settings'));
      default:
        return const HomeView(key: ValueKey('default'));
    }
  }
  // À mettre en haut du fichier

  AppBar _buildAppBar(BuildContext context) {
    String titleText;

    switch (_selectedIndex) {
      case 0:
        titleText = "Mes connexions";
        break;
      case 1:
        titleText = "Notifications";
        break;
      case 2:
        titleText = "Paramètres";
        break;
      default:
        titleText = "Racine";
    }

    return AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white70,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset("assets/racine-logo.png", width: 40),
          const SizedBox(width: 12),
          Text(titleText, style: const TextStyle(fontFamily: 'Orbitron')),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.open_in_new),
          onPressed: () {},
          tooltip: "Visiter la plateforme",
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black.withOpacity(0.3),
      selectedItemColor: activeColor,
      unselectedItemColor: primaryColor,
      currentIndex: _selectedIndex,
      onTap: (int index) => setState(() => _selectedIndex = index),
      items: [
        _navItem(Icons.apps, "Acceuil", 0),
        _navItem(Icons.notifications, "Notifications", 1),
        _navItem(Icons.settings, "Paramètres", 2),
      ],
    );
  }

  BottomNavigationBarItem _navItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    final Color pinkColor = isSelected ? activeColor : primaryColor;

    return BottomNavigationBarItem(
      icon: Icon(icon, color: pinkColor),
      label: label,
    );
  }
}
