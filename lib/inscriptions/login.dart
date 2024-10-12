
import 'dart:developer';

import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/controllers/auth.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/inscriptions/register.dart';
import 'package:app_coaching/widgets/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthenticateController _authenticateController = Get.put(AuthenticateController());
  bool isObscurityText = true;
  String _phonecode = "";



@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    final expiresAt = GetStorage().read("expires_at");
    final accessToken = GetStorage().read("access_token");
    if (accessToken != null && expiresAt != null) {
      Get.offAll(() => const Base());
    }
  });
}


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width(context) * 0.05,
              vertical: height(context) * 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipOval(
                  child: Image.asset(
                "assets/images/logo.png",
                width: 90,
              )),
              Padding(
                padding: EdgeInsets.only(top: height(context) * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IntlPhoneField(
                        controller: _phoneController,
                        initialCountryCode: "CI",
                        cursorColor: AppColors.primaryColor,
                        // onCountryChanged: (country) {
                        //   _dialcode = country.dialCode;
                        //   print(_dialcode);
                        // },
                        onChanged: (phone) {
                          _phonecode = phone.completeNumber;
                          // print(phone.completeNumber);
                        },
                        decoration: InputDecoration(
                          hintText: "Numéro de téléphone",
                          labelText: "Entrez votre numéro de téléphone",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(style: BorderStyle.solid)),
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: isObscurityText,
                        keyboardType: TextInputType.visiblePassword,
                        // obscureText: widget.obscureText && isObscure,
                        decoration: InputDecoration(
                          hintText: "Ex: ******",
                          labelText: "Entrez votre mot de passe",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding),
                            child: Icon(
                              Icons.lock,
                              color: AppColors.primaryColor,
                              size: 16,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscurityText = !isObscurityText;
                              });
                            },
                            icon: Icon(
                              isObscurityText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primaryColor,
                              size: 16,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(style: BorderStyle.solid)),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir un mot de passe';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height(context) * 0.1),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await _authenticateController.Login(
                        phone: _phonecode,
                        password: _passwordController.text.trim(),
                      );
                    }
                  },
                  child: Obx(() {
                    return _authenticateController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "CONNEXION",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          );
                  }),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(345, 55)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // route(context, ForgetPasswordPage()),
                    },
                    child: Text(
                      "Mot de pass oublié ?",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 204, 170, 112),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous n'avez pas de compte ?",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const Register());
                    },
                    child: Text(
                      "Inscription",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 204, 170, 112),
                      ),
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

