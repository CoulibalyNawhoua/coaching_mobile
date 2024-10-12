import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/widgets/appBar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String description;
  final DateTime dateTime;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.dateTime,
  });
}

class _NotificationPageState extends State<NotificationPage> {
  final List _notifications = [
    NotificationItem(
      icon: Icons.notifications,
      title: "Nouvelle notification",
      description: "Ceci est une nouvelle notification importante.",
      dateTime: DateTime.now(),
    ),
    NotificationItem(
      icon: Icons.notifications,
      title: "Notification quotidienne",
      description: "Ne pas oublier de faire quelque chose aujourd'hui.",
      dateTime: DateTime.now().subtract(Duration(hours: 2)),
    ),
    // Ajoutez autant de diapositives que vous le souhaitez
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CappBar(title: "Notifications"),
        body: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            return SizedBox(child: ListItem(content: _notifications[index]));
          },
        ));
  }
}

class ListItem extends StatelessWidget {
  final NotificationItem content;

  ListItem({required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.notifications,
                size: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      // fontSize: 16,
                    ),
                  ),
                  Text(
                    content.description,
                  ),
                ],
              ),
              // Icon(Icons.download)
              IconButton(onPressed: () {}, icon: Icon(Icons.download)),
            ],
          )

          // SizedBox(height: 20,),
        ],
      ),
    );
  }
}
