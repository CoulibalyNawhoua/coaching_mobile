import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/views/evenements.dart';
import 'package:app_coaching/views/home.dart';
import 'package:app_coaching/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/auth.dart';
import '../models/user.dart';

class Base extends StatefulWidget {
  final int? CategorieID;
  const Base({super.key,this.CategorieID,});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  var userInfo = User.fromJson(GetStorage().read("user_info"));
  int currentIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(CategorieID: widget.CategorieID),
      Evenement(),
      Profile(),
    ];
    
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //    authenticateController.checkTokenExpiration();
    //   // if (!mounted) {
    //   //  authenticateController.checkTokenExpiration();
    //   // }
    // });
    
  }
   void goToPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  // List _pages = [
  //   HomePage(widget.CategorieID!),
  //   Evenement(),
  //   Profile(),
    
  // ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
              gap: 7,
              backgroundColor: AppColors.primaryColor,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: AppColors.secondaryColor,
              padding: EdgeInsets.all(14),
              selectedIndex: currentIndex,
              onTabChange: (index) => goToPage(index),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Accueil",
                  
                ),
                GButton(icon: Icons.event, text: "Agenda"),
                // GButton(icon: Icons.favorite_border, text: "Librairies"),
                GButton(icon: Icons.person, text: "Profil"),
              ]),
        ),
      ),
    );
  }
}
