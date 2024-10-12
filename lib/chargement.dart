import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/inscriptions/login.dart';
// import 'package:app_coaching/inscriptions/login.dart';
import 'package:app_coaching/inscriptions/register.dart';
import 'package:app_coaching/widgets/button.dart';
import 'package:flutter/material.dart';


class ChargementPage extends StatefulWidget {
  @override
  State<ChargementPage> createState() => _ChargementPageState();
}

class _ChargementPageState extends State<ChargementPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "WELCOME",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod! ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: width(context),
                height: height(context) * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Mobile_login.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  CButton(
                      title: "INSCRIPTION",
                      onPressed: () {
                        //  Get.to(() => const Register());
                        route(context, Register());
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      route(context, LoginPage());
                      //  Get.to(() => const Login());
                    },
                    child: Text(
                      "CONNEXION",
                      style: TextStyle(
                          fontSize: 18, color: AppColors.primaryColor),
                    ),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(345, 55)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              width: 2, color: AppColors.primaryColor),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ), //verifier si la couleur est nul (si oui alors on lui donne la couleur pas defaut)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
