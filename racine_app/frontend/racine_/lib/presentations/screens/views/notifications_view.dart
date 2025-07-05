import 'package:flutter/material.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Connexion réussie',
      'text': 'Vous vous êtes connecté à Tôswè via Racine.',
      'time': 'Il y a 2 minutes',
      'read': false,
      'action': () => debugPrint("Voir détails de Tôswè"),
    },
    {
      'title': 'Nouvelle plateforme liée',
      'text': 'La plateforme LearnAfrik a accédé à vos infos publiques.',
      'time': "Aujourd'hui",
      'read': false,
      'action': () => debugPrint("Voir autorisations LearnAfrik"),
    },
    {
      'title': 'Session expirée',
      'text': 'Votre session avec YonnApp a expiré.',
      'time': 'Hier',
      'read': true,
      'action': () => debugPrint("Reconnexion à YonnApp"),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return notifications.isEmpty
        ? Center(
            child: Text(
              "Aucune notification pour le moment",
              style: TextStyle(color: Colors.white70),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 16, 16, 16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return Dismissible(
                key: Key(notif['title'] + notif['time']),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  setState(() => notifications.removeAt(index));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.pinkAccent,
                      content: Text("Notification supprimée"),
                    ),
                  );
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.redAccent,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  color: Colors.white.withOpacity(0.05),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.white.withOpacity(0.15)),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      notif['action']();
                      setState(() => notif['read'] = true);
                    },
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (!notif['read'])
                          const Icon(
                            Icons.brightness_1,
                            size: 10,
                            color: Colors.pinkAccent,
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notif['text'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notif['time'],
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
