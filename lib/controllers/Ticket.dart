import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app_coaching/views/paiement.dart';
import 'package:app_coaching/views/ticket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../api/api_constante.dart';
import '../models/ticket.dart';
import '../views/detail_ticket.dart';

class TicketEvenementController extends GetxController {
  final isLoading = false.obs;
  final token = GetStorage().read("access_token");
  String status = "";

  Future<List<EventTicket>> getTicketEvent(int dateId) async {
    List<EventTicket> ListTicket = [];

    var response =
        await http.get(Uri.parse(Api.getTicketEvent(dateId)), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    try {
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        for (var item in responseBody as List) {
          ListTicket.add(EventTicket.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print("Aucun ticket trouvé");
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
    return ListTicket;
  }

  Future<void> verifyTicketQuantity(data) async {
    var quantity = data['quantity'];
    var ticketID = data['id_tickets'];
    try {
      var data = {
        'quantity': quantity.toString(),
        'id_tickets': ticketID.toString(),
      };
      var response = await http.post(
        Uri.parse(Api.verificationTicket), 
        headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        DetailsTicket ticketDetails = DetailsTicket.fromJson(responseBody['details-ticket']);
        print("Quantité restante en base après achat : $responseBody");
        Get.to(AchatTicketPage(ticketDetails: ticketDetails));

      } else {
        isLoading.value = false;
        print("error");
        Get.snackbar(
          'Achat : ',
          'Quantité insuffisante de tickets',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> AchatTicket(data) async {

    var quantity = data['quantity'];
    var montantPaye = data['montants_paye'];
    var ticketID = data['id_tickets'];

    try {

      isLoading.value = true;

      var data = {
        'quantity': quantity.toString(),
        'montants_paye': montantPaye.toString(),
        'id_tickets': ticketID.toString(),
      };
      
      var response = await http.post(
        Uri.parse(Api.AchatTickets),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      if (response.statusCode == 200) {

        isLoading.value = false;

        var responseBody = jsonDecode(response.body);

        if (responseBody["status"] == 1) {

          Get.to(Paiement(
          url: responseBody["payment_url"],
          paiementId: responseBody["paiement_id"],
          transactionId: responseBody["transaction_id"],
          achatTicketId: responseBody["achat_tickets_id"],
          ));

        }else{
          Get.snackbar(
          'Echec : ',
          responseBody["message"],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          );

          inspect(responseBody["Error"]);
        }
      } else {

        isLoading.value = false;

        print("error");
        // Get.snackbar(
        //   'Achat : ',
        //   "Echec de l'achat",
        //   snackPosition: SnackPosition.TOP,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> updateStatusPaiementAchat(paiementId,achatTicketId) async {
    try {
      isLoading.value = true;
      var response = await http.put(
        Uri.parse(Api.updateStatusPaiementAchat(paiementId,achatTicketId)),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = json.decode(response.body);
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

  Future<void> checkPayment(String transactionId, int paiementId, int achatTicketId) async {
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
          updateStatusPaiementAchat(paiementId, achatTicketId);
          // timer.cancel();

          timer = Timer(Duration(seconds: 20), () {
            getTicket();
          });
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

  Future<void> getTicket() async {
    try {
      var response =
          await http.get(Uri.parse(Api.getTicket()), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      // inspect(response);

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body)['ticket_infos'];
        TicketInfo ticketInfo  = TicketInfo.fromJson(responseBody);
        
        Get.to(MyTicket(ticketInfo: ticketInfo));
      } else {
        isLoading.value = false;

        print("aucun detail trouvé");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
