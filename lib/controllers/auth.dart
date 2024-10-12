import 'dart:convert';

import 'package:app_coaching/api/api_constante.dart';
import 'package:app_coaching/inscriptions/login.dart';
import 'package:app_coaching/widgets/base.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class AuthenticateController extends GetxController {
  final isLoading = false.obs;
  final token = "".obs;

  String message(String message) {
    switch (message) {
      case "vos identifiant sont incorrect":
        message = "Nom d'utilisateur ou mot de passe incorrect";
        break;
      default:
        message = message;
    }
    return message;
  }


Future<void> checkTokenExpiration(isMounted) async {
  try {
    var accessToken = GetStorage().read("access_token");
    var expiresAt = GetStorage().read("expires_at");

    if (accessToken != null && expiresAt != null) {
      DateTime expirationDate = DateTime.parse(expiresAt);
      bool isExpired = DateTime.now().isAfter(expirationDate);

      if (isExpired) {
        await logout();
        if (isMounted) { //isMounted pour vérifier l'état du widget
          Get.offAll(() => const LoginPage());
        }
      } else {
        // Get.to(Base());
      }
    } else {
      await logout();
      if (isMounted) { //isMounted pour vérifier l'état du widget
        Get.to(() => const LoginPage());
      }
      print("error");
    }
  } catch (e) {
    // Gestion des erreurs
    if (kDebugMode) {
      print("Error: $e");
    }
  
  }
}




  // Méthode à définir pour déconnecter l'utilisateur
  Future<void> logout() async {
    GetStorage().remove("access_token");
    GetStorage().remove("expires_at");
    GetStorage().remove("user_info");
  }

  void deconnectUser() {
    Get.defaultDialog(
      title: "Déconnexion",
      middleText: "Voulez-vous vraiment vous déconnecter ?",
      backgroundColor: Colors.white,
      radius: 0,
      confirm: TextButton(
        onPressed: () {
          GetStorage().remove("access_token");
          Get.offAll(() => const LoginPage());
        },
        child: Text(
          "Déconnexion",
          style: TextStyle(color: Colors.red),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          "Annuler",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }


  Future<void> Register({
    required String first_name,
    required String last_name,
    required String phone,
    required String password,
    required String password_confirmation,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'first_name': first_name,
        'last_name': last_name,
        'phone': phone,
        'password': password,
        'password_confirmation': password_confirmation,
      };
      var response = await http.post(
        Uri.parse(Api.register),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 201) {
        isLoading.value = false;

        Get.snackbar(
          'Inscription : ',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // print(json.decode(response.body));
        Get.offAll(() => const LoginPage());
      } else {
        isLoading.value = false;

        // Get.snackbar(
        //   'Inscription : ',
        //   json.decode(response.body)['message'],
        //   snackPosition: SnackPosition.TOP,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );

        if (kDebugMode) {
          print(json.decode(response.body));
        }
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future<void> Login({
    required String phone,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'phone': phone,
        'password': password,
      };

      var response = await http.post(
        Uri.parse(Api.login),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = json.decode(response.body);
        var userResponse = UserResponse.fromJson(responseBody);
        // token.value = responseBody["access_token"];
        token.value = userResponse.accessToken;
        var expiresAt = userResponse.expiresAt;
       
        Get.snackbar(
          'Connexion : ',
          message(json.decode(response.body)['message']),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
          await GetStorage().write("access_token", token.value);
          await GetStorage().write("user_info", userResponse.userInfo.toJson());
          await GetStorage().write("expires_at", expiresAt);
         

          Get.to(() => const Base());

      } else {

        isLoading.value = false;

        Get.snackbar(
          'Connexion : ',
          message(json.decode(response.body)['message']),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        if (kDebugMode) {
          print(json.decode(response.body));
        }
      }
    } catch (e) {
      
      isLoading.value = false;
      if (kDebugMode) {
        print("Error: $e");
      } // Pas besoin de convertir e en chaîne avec toString()
    }
  }

   
}
