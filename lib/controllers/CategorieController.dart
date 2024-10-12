import 'dart:convert';

import 'package:app_coaching/api/api_constante.dart';
import 'package:app_coaching/models/categorie_citation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CategorieCitationController extends GetxController {
  final isLoading = false.obs;
  final token = GetStorage().read("access_token");

  // @override
  // void onInit() {
  //   getCategorieCitation();
  //   super.onInit();
  // }

  Future<List<CategorieCitation>> getCategorieCitation() async {
    List<CategorieCitation> ListcategorieCitation = [];
    try {
      ListcategorieCitation.clear(); // Use 'await' here if necessary

      var response = await http.get(Uri.parse(Api.CategorieCitation), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);

        for (var item in responseBody["data"]["original"]["data"]) {
          if (item is Map<String, dynamic>) {
            ListcategorieCitation.add(CategorieCitation.fromJson(item));
          } else {
            print("echec");
          }
        }
        print(ListcategorieCitation);
      } else {
        isLoading.value = false;

        print("Erreur lors de la récupération des catégories");

        // Get.snackbar(
        //   'Error : ',
        //   json.decode(response.body)['message'],
        //   snackPosition: SnackPosition.TOP,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        //   forwardAnimationCurve: Curves.elasticInOut,
        //   reverseAnimationCurve: Curves.easeOut,
        // );

        if (kDebugMode) {
          print(json.decode(response.body));
        }
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
    return ListcategorieCitation;
  }

  // Future<void> verificationSouscription() async {
  //   try {
  //     isLoading.value = true;
  //     var response = await http.get(
  //       Uri.parse(Api.VerificationAbonnement),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var responseBody = jsonDecode(response.body);
  //       final abonnement = responseBody['abonnement'];
  //       // Vérifier si l'utilisateur a un abonnement actif
        
  //       if (abonnement != null) {
  //         isUnlocked.value = true; // déverrouiller la catégorie si l'abonnement est actif
  //       }
  //     } else {
  //       isLoading.value = false;
  //       print("Erreur lors de la récupération de l'abonnement");
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     print(e);
  //   }
  // }
}
