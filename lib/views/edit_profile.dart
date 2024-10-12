import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/widgets/appBar.dart';
import 'package:app_coaching/widgets/button.dart';
import 'package:app_coaching/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController phoneController =
      TextEditingController(text: "0102030405");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CappBar(title: "Modification"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: clipperModule(),
                  child: Container(
                    color: AppColors.secondaryColor,
                    height: height(context) * 0.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                              bottom: height(context) * 0.01),
                              // width: width(context) * 0.4,
                              // height: height(context) * 0.2,
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                    // width: width(context) *0.015,
                                  ),
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/debora.jpeg"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  // size: 16,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Form(
                            child: Column(
                              children: [
                                CTextFormField(
                                  keyboardType: TextInputType.name,
                                  // hintText: "Ex: ABAKA",
                                  prefixIcon: Icons.person,
                                  initialValue: "ABAKA",
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CTextFormField(
                                    keyboardType: TextInputType.name,
                                    // hintText: "Ex: Déborah",
                                    prefixIcon: Icons.person,
                                    initialValue: "Déborah"),
                                SizedBox(
                                  height: 20,
                                ),
                                InputPhone(),
                                SizedBox(
                                  height: 10,
                                ),
                                CpasswordFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  initialValue: "******",
                                  labelText: "Entrez votre mot de passe",
                                  prefixIcon: Icons.lock,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CpasswordFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  initialValue: "******",
                                  labelText: "Entrez nouveau mot de passe",
                                  prefixIcon: Icons.lock,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CButton(title: "Enregistrer", onPressed: () {})
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  IntlPhoneField InputPhone() {
    return IntlPhoneField(
      controller: phoneController,
      initialCountryCode: "CI",
      cursorColor: AppColors.primaryColor,
      // initialValue: "0102030405",
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: AppColors.secondaryColor,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(style: BorderStyle.solid)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              // width: 1,
              ),
        ),
      ),
    );
  }
}

class clipperModule extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
