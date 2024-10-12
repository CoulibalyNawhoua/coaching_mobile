import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../constantes/constantes.dart';
import '../controllers/auth.dart';
import '../fonctions/fonction.dart';
import '../inscriptions/register.dart';
import '../widgets/base.dart';

class ModifierPwd extends StatefulWidget {
  const ModifierPwd({super.key});

  @override
  State<ModifierPwd> createState() => _ModifierPwdState();
}

class _ModifierPwdState extends State<ModifierPwd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthenticateController _authenticateController = Get.put(AuthenticateController());
      

  String _phonecode = "";
  bool isObscurityText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Modifier mot de passe",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
       
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //  ClipOval(
              //     child: Image.asset(
              //   "assets/images/logo.png",
              //   width: 90,
              // )),
              // SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(context) * 0.05,vertical: height(context) * 0.1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: isObscurityText,
                        keyboardType: TextInputType.visiblePassword,
                        // obscureText: widget.obscureText && isObscure,
                        decoration: InputDecoration(
                          hintText: "Ex: ******",
                          labelText: "Entrez ancien mot de passe",
                          labelStyle: TextStyle(
                            fontSize: 14,
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
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: isObscurityText,
                        keyboardType: TextInputType.visiblePassword,
                        // obscureText: widget.obscureText && isObscure,
                        decoration: InputDecoration(
                          hintText: "Ex: ******",
                          labelText: "Entrez nouveau mot de passe",
                          labelStyle: TextStyle(
                            fontSize: 14,
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
                            return 'Veuillez saisir le nouveau mot de passe';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
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
                            fontSize: 14,
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
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    // if (_formKey.currentState?.validate() ?? false) {
                    //   await _authenticateController.Register(
                    //     password: _passwordController.text.trim(),
                    //     password_confirmation: _confirmPasswordController.text.trim(),
                            
                    //   );
                    // }
                  },
                  child: Obx(() {
                    return _authenticateController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "MODIFIER",
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
            ],
          ),
       
      ),
    );
  }
}
