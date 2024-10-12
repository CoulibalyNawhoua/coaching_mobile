import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app_coaching/views/souscriptionAb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../api/api_constante.dart';
import '../models/abonnement.dart';

class AbonnementController extends GetxController {
  final isLoading = false.obs;
  final token = GetStorage().read("access_token");
  var hasSubscription = false.obs;
  var expired = true.obs;
  var listAbonnement = <Abonnement>[].obs;
  var abonnementUser = <Abonnement>[].obs;
  RxString libelle = "".obs;
  RxList<Offre> offres = <Offre>[].obs;

  Future<void> getAbonnement() async {
    var response = await http.get(Uri.parse(Api.Abonnement), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    try {
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body)['abonnements'];
        List<dynamic> abonnementsJson = responseBody;
        List<Abonnement> abonnements =
            abonnementsJson.map((json) => Abonnement.fromJson(json)).toList();

        // Convertir la liste en RxList<Abonnement>
        listAbonnement.assignAll(abonnements);
        //  inspect(abonnements);
      } else {
        isLoading.value = false;

        print("Aucun abonnement trouvé");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOffresByAbonnement(int abonId) async {
    try {
      var response =
          await http.get(Uri.parse(Api.getDetailAbonnement(abonId)), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        libelle.value = responseBody['libelle'];

        // Vérifiez que le champ 'offres' existe dans la réponse JSON
        if (responseBody.containsKey('offres')) {
          var offresJson = responseBody['offres'];
          List<dynamic> offresListJson = offresJson;
          offres.assignAll(
              offresListJson.map((json) => Offre.fromJson(json)).toList());
        } else {
          // Gérer le cas où le champ 'offres' n'est pas présent dans la réponse JSON
          print("Champ 'offres' manquant dans la réponse JSON");
        }
      } else {
        throw Exception('Failed to load offres');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> SouscriptionAbonnement(
      int abonnementId, String prixAbonnement) async {
    // var abonnementId = data['id_abonnement'];
    // var prixAbonnement = data['prix_abonnements'];
    try {
      isLoading.value = true;
      var data = {
        'id_abonnement': abonnementId.toString(),
        'prix_abonnements': prixAbonnement.toString(),
      };
      var response = await http.post(
        Uri.parse(Api.SouscriptionAbonnement),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: data,
      );
      // inspect(response);
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        Get.to(SouscriptionAbonnementPage(
          url: responseBody["payment_url"],
          transactionId: responseBody["transaction_id"],
          paiementId: responseBody["paiement_id"],
          souscriptionId: responseBody["souscription_id"],
        ));
      } else {
        isLoading.value = false;

        Get.snackbar(
          'Echec : ',
          "echec du paiement",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        print("echec du paiement");
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> checkPayment(
      String transactionId, int paiementId, int souscriptionId) async {
    Timer timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      var data = {
        "apiKey": "262425053964adkcz02q1x.7323710",
        "site_id": "6076583",
        "transaction_id": transactionId,
      };

      var url = Uri.parse(
          "https://distripay-sanbox-api.distriforce.shop/api/check/verify");

      var response = await http.post(
        url,
        body: data,
        headers: {
          'Accept': 'application/json',
        },
      );

      // inspect(response);
      if (response.statusCode == 200) {
        if (json.decode(response.body)["code"] == "00") {
          //Faire update du status de paiement
          updateStatusSouscription(paiementId, souscriptionId);
          timer.cancel();
        } else {
          inspect(json.decode(response.body));
        }
      } else {
        timer.cancel();
      }
    });

    Future.delayed(Duration(seconds: 300), () {
      timer.cancel();
    });
  }

  Future<void> updateStatusSouscription(paiementId, souscriptionId) async {
    try {
      isLoading.value = true;
      var response = await http.put(
        Uri.parse(Api.updateStatusPaiementAbon(paiementId, souscriptionId)),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = json.decode(response.body);

        // await GetStorage().write('abonnement_info', responseBody['abonnement_info']);
        print("Statut de paiement mis à jour avec succès: $responseBody");
        
      } else {
        isLoading.value = false;
        print("Erreur lors de la récupération du statut du paiement");
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> checkAbonnement() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse(Api.checkAbonnement),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = json.decode(response.body);
        hasSubscription.value = responseBody['has_subscription'];
        expired.value = responseBody['expired'];
        // inspect(hasSubscription.value);
        print('has_subscription: $hasSubscription');
        print('expired: $expired');
      } else {
        isLoading.value = false;
        print('Erreur: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Erreur: $e');
    }
  }

  Future<void> getAbonnementUtilisateur() async {
    try {
      abonnementUser.clear(); 
      isLoading.value = true;
      var response = await http.get(
        Uri.parse(Api.getUserAbonnement),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = json.decode(response.body);

        // Vérifiez si le champ 'abonnement' existe dans la réponse JSON
        if (responseBody.containsKey('abonnement')) {
          var abonnementJson = responseBody['abonnement'];
          Abonnement abonnement = Abonnement.fromJson(abonnementJson);
          abonnementUser.assign(abonnement);
        } else {
          print("Champ 'abonnement' manquant dans la réponse JSON");
        }

        if (responseBody.containsKey('offres')) {
          var offresJson = responseBody['offres'];
          List<dynamic> offresListJson = offresJson;
          List<Offre> offresList = offresListJson.map((json) => Offre.fromJson(json)).toList();
              
          offres.assignAll(offresList);
        } else {
          print("Champ 'offres' manquant dans la réponse JSON");
        }
      } else {
        isLoading.value = false;
        throw Exception('Failed to load abonnement and offres');
      }
    } catch (e) {
      isLoading.value = false;
      print('Erreur: $e');
    }
  }

  Future<void> getAccesUtilisateur() async {
    try {
      // Vérifiez si l'utilisateur a un abonnement
      isLoading.value = true;
      var response = await http.get(
        Uri.parse(Api.getAccesUtilisateur),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = json.decode(response.body);
        // Vérifiez si l'utilisateur a un abonnement
        var categorieAbonnement = responseBody['categorie_abonnement'];
        if (categorieAbonnement != null) {
          if (categorieAbonnement == 'Starter') {
            var citations = responseBody['citations'];
            print('recuération des citations: $citations');
          } else if (categorieAbonnement == 'Members') {
            // var citations = responseBody['citations'];
            // var tauxReduction = responseBody['taux_reduction'];
            // var tauxReduction = responseBody['taux_reduction'];
            // var tickets = responseBody['tickets'];
            var membersData = {
              'citations': responseBody['citations'],
              'tauxReduction': responseBody['reduction_achat_ticket'],
              'tickets': responseBody['tickets'],
            };
            print('Abonnement Members: $membersData');
          } else {
            var membersData = {
              'citations': responseBody['citations'],
              'tauxReduction': responseBody['reduction_achat_ticket'],
              'tickets': responseBody['tickets'],
            };
            print('Abonnement Essentials: $membersData');
          }
        } else {
          print('L\'utilisateur n\'a pas d\'abonnement.');
        }
      } else {
        isLoading.value = false;
        print("Échec de la récupération des données d\'abonnement");
      }
    } catch (e) {
      isLoading.value = false;
      print('Erreur lors de la récupération des données d\'abonnement: $e');
    }
  }
}
