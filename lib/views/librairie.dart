import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/widgets/tabs/first_tab.dart';
import 'package:app_coaching/widgets/tabs/second_tab.dart';
import 'package:app_coaching/widgets/tabs/third_tab.dart';
import 'package:flutter/material.dart';

class Librairie extends StatefulWidget {
  const Librairie({super.key});

  @override
  State<Librairie> createState() => _LibrairieState();
}

class _LibrairieState extends State<Librairie>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  late String selectedTabTitle = "Citations"; // Titre initial

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {
        // Mettre à jour le titre lorsque l'onglet sélectionné change
        selectedTabTitle = ["Citations", "Audios", "Vidéos"][controller.index];
      });
    });
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          title: SizedBox(
            height: 35,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 15,
                      child: Image.asset(
                        "assets/icons/search.png",
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Recherche...",
                        // filled: true,
                        // fillColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // title: Text(
          //   selectedTabTitle,
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold
          //   ),
          //   // Afficher le titre de l'onglet sélectionné
          // ),
          centerTitle: true,
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(text: "Citations"),
              Tab(text: "Audios"),
              Tab(text: "Vidéos"),
            ],
            labelColor: Colors.white,
            labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white), // Style pour les onglets sélectionnés
            unselectedLabelStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey), // Style pour les onglets non sélectionnés
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            FirstTab(),
            SecondTab(),
            ThirdTab(),
          ],
        ),
      ),
    );
  }
}
