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
      'type': 'Sécurité',
      'action': () => debugPrint("Voir détails de Tôswè"),
    },
    {
      'title': 'Nouvelle plateforme liée',
      'text': 'La plateforme LearnAfrik a accédé à vos infos publiques.',
      'time': "Aujourd'hui",
      'read': false,
      'type': 'Plateformes',
      'action': () => debugPrint("Voir autorisations LearnAfrik"),
    },
    {
      'title': 'Session expirée',
      'text': 'Votre session avec YonnApp a expiré.',
      'time': 'Hier',
      'read': true,
      'type': 'Activité',
      'action': () => debugPrint("Reconnexion à YonnApp"),
    },
  ];

  String selectedFilter = 'Tout';
  final List<String> filters = [
    'Tout',
    'Plateformes',
    'Applications',
    'Activité',
    'Sécurité',
  ];

  int get unreadCount => notifications.where((n) => n['read'] == false).length;

  @override
  Widget build(BuildContext context) {
    final filteredNotifications = selectedFilter == 'Tout'
        ? notifications
        : notifications.where((n) => n['type'] == selectedFilter).toList();

    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              /*const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),*/
              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$unreadCount non lues',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: filters.map((filter) {
              final isSelected = filter == selectedFilter;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => setState(() => selectedFilter = filter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.pinkAccent : Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                for (var notif in notifications) {
                  notif['read'] = true;
                }
              });
            },
            icon: const Icon(
              Icons.mark_email_read_outlined,
              color: Colors.white70,
            ),
            label: const Text(
              "Tout marquer comme lu",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: filteredNotifications.isEmpty
              ? const Center(
                  child: Text(
                    "Aucune notification pour le moment",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: filteredNotifications.length,
                  itemBuilder: (context, index) {
                    final notif = filteredNotifications[index];
                    return Dismissible(
                      key: Key(notif['title'] + notif['time']),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.grey[900],
                            title: const Text(
                              "Supprimer cette notification ?",
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text(
                              "Cette action est irréversible.",
                              style: TextStyle(color: Colors.white70),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("Annuler"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("Supprimer"),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (_) {
                        setState(() => notifications.remove(notif));
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
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: notif['read'] ? 0.6 : 1.0,
                        child: Card(
                          color: Colors.white.withOpacity(0.05),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.15),
                            ),
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
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
