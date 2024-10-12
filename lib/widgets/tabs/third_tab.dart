import 'package:app_coaching/constantes/constantes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListContent {
  final String title;
  final String subtitle;

  ListContent({required this.title, required this.subtitle});
}

class ThirdTab extends StatelessWidget {
  final List _videos = [
    // Ajoutez autant de diapositives que vous le souhaitez
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
    ListContent(title: "Coaching “ Changer de vie”", subtitle: "Déborah Abaka"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: _videos.length,
      itemBuilder: (context, index) {
        return SizedBox(child: ListItem(content: _videos[index]));
      },
    ));
  }
}

class ListItem extends StatelessWidget {
  final ListContent content;

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
                FontAwesomeIcons.video,
                // size: 32,
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
                  Text(content.subtitle,),
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