import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/controllers/auth.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/inscriptions/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _first_nameController = TextEditingController();
  final _last_nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthenticateController _authenticateController = Get.put(AuthenticateController());
      
  String _phonecode = "";
  bool isObscurityText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width(context) * 0.05,
              vertical: height(context) * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipOval(
                    child: Image.asset(
                  "assets/images/logo.png",
                  width: 90,
                  // height: 150,
                )),
              
              // Container(
              //   width: width(context) * 0.3,
              //   height: height(context) * 0.15,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     image: DecorationImage(
              //       image: AssetImage("assets/images/logo.png"),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _first_nameController,
                      keyboardType: TextInputType.name,
                      //cachez le texte a la saisir)
                      obscureText: false,
                      // cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: "KOUAKOU",
                        labelText: "Entrez votre nom",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          child: Icon(
                            Icons.person,
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
                          return 'Veuillez saisir votre nom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _last_nameController,
                      keyboardType: TextInputType.name,
                      //cachez le texte a la saisir)
                      obscureText: false,
                      // cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: "Ex: Albert",
                        labelText: "Entrez votre prénom",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          child: Icon(
                            Icons.person,
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
                          return 'Veuillez saisir votre prénom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    IntlPhoneField(
                      controller: _phoneController,
                      initialCountryCode: "CI",
                      cursorColor: AppColors.primaryColor,
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
                      height: 15,
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
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: isObscurityText,
                      keyboardType: TextInputType.visiblePassword,
                      // obscureText: widget.obscureText && isObscure,
                      decoration: InputDecoration(
                        hintText: "Ex: ******",
                        labelText: "Confirmez le mot de passe",
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
                          return 'Veuillez confirmer nouveau mot de passe';
                        } else if (value != _passwordController.text) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height(context) * 0.04),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await _authenticateController.Register(
                        first_name: _first_nameController.text.trim(),
                        last_name: _last_nameController.text.trim(),
                        phone: _phonecode,
                        password: _passwordController.text.trim(),
                        password_confirmation:
                            _confirmPasswordController.text.trim(),
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
                            "INSCRIPTION",
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
                  Text(
                    "Avez-vous un compte ?",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LoginPage());
                    },
                    child: Text(
                      "Connexion",
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
