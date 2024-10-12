import 'dart:developer';

import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/views/modifier_password.dart';
import 'package:app_coaching/views/user_abonnement.dart';
import 'package:app_coaching/views/user_profil.dart';
import 'package:app_coaching/widgets/base.dart';
import 'package:app_coaching/widgets/profil_clipper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/api_constante.dart';
import '../controllers/auth.dart';
import '../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  // final UserController userController = Get.put(UserController());
  bool isMounted = false;
  User? user;

  @override
  void initState() {
    super.initState();
    isMounted = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await authenticateController.checkTokenExpiration(isMounted);
      getUserData();
      // await userController.getUserInfo();
    });
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  Future<void> getUserData() async {
    var userData = GetStorage().read<Map<String, dynamic>>("user_info");
    if (userData != null ) {
      setState(() {
        user = User.fromJson(userData);
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    // inspect(user);
    return Scaffold(
      // backgroundColor: AppColors.secondaryColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (user != null)
            ClipperCustom(
              image: user!.urlPhoto != null
                ? "${Api.imageUrl}${user!.urlPhoto}"
                : "assets/images/ai-generated-8083323_1280.jpg",
              name: user!.firstName + ' ' + user!.lastName,
              phone: user!.email ?? user!.phone,
            ),
            // FutureBuilder(
            //   future: userController.getUserInfo(),
            //   builder: (context,snapshot) {
            //     if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else if (snapshot.data == null) {
            //       return Center(child: CircularProgressIndicator());
            //     } else {
            //       final user = snapshot.data!; 
            //      return ClipperCustom(
            //       image: user.urlPhoto != null
            //           ? "${Api.imageUrl}${user.urlPhoto}"
            //           : "assets/images/ai-generated-8083323_1280.jpg",
            //       name: user.firstName + ' ' + user.lastName,
            //       phone: user.email ?? user.phone,
            //     );

            //     }
            //   },
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height(context) * 0.05),
              child: Column(
                children: [
                  ProfileMenuItem(
                    iconSrc: Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    ),
                    title: "Profil",
                    onpress: () {
                      Get.to(UserProfile());
                    }
                  ),
                  ProfileMenuItem(
                    iconSrc: Icon(
                      Icons.subscriptions,
                      color: AppColors.primaryColor,
                    ),
                    title: "Abonnements",
                    onpress: () {
                      Get.to(UserAbonnement());
                    }
                  ),
                  // ProfileMenuItem(
                  //     iconSrc: Icon(
                  //       Icons.notifications,
                  //       color: AppColors.primaryColor,
                  //     ),
                  //     title: "Notification",
                  //     onpress: () {
                  //       Get.to(ModifierPwd());
                  //     }),
                  // ProfileMenuItem(
                  //   iconSrc: Icon(
                  //     Icons.home,
                  //     color: AppColors.primaryColor,
                  //   ),
                  //   title: "Accueil",
                  //   onpress: () {
                  //     Get.to(Base());
                  //   }
                  // ),
                  ProfileMenuItem(
                    iconSrc: Icon(
                      Icons.logout,
                      color: AppColors.primaryColor,
                    ),
                    title: "Déconnexion",
                    onpress: () {
                      authenticateController.deconnectUser();
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
              
            
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text(
        "Mon Compte",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      elevation: 0.0,
      leading: SizedBox(),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.iconSrc,
    required this.title,
    required this.onpress,
  });
  final Icon iconSrc;
  final String title;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: SafeArea(
              child: Row(
                children: [
                  iconSrc,
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF8492A2),
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    // size: width(context) * 0.05,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
