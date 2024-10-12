import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth.dart';
import '../views/modifier_password.dart';

class ProfileDropdown extends StatefulWidget {
  const ProfileDropdown({super.key});

  @override
  State<ProfileDropdown> createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<ProfileDropdown> {
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        items: [
          DropdownMenuItem(
            value: 'modifier_mdp',
            child: Text("Modifier le mot de passe"),
          ),
          DropdownMenuItem(
            value: 'deconnexion',
            child: Text("Déconnexion",style: TextStyle(color: Colors.red),),
          ),
        ],
        onChanged: (value) {
          if (value == 'modifier_mdp') {
             Get.to(ModifierPwd());
          } else if (value == 'deconnexion') {
            authenticateController.deconnectUser();
          }
        },
      ),
    );
  }
}