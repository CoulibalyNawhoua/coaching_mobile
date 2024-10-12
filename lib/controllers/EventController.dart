import 'dart:convert';

import 'package:app_coaching/api/api_constante.dart';
import 'package:app_coaching/models/event.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class EvenementController extends GetxController {
  var isLoading = false.obs;
  final token = GetStorage().read("access_token");


  Future<List<Evenement>> getEvenement() async {
    List<Evenement> ListEvents = [];
    try {
      var response = await http.get(Uri.parse(Api.Evenements), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        for (var item in responseBody as List) {
          ListEvents.add(Evenement.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print("Aucun évènement trouvé");

        // Get.snackbar(
        //   'Error : ',
        //   json.decode(response.body)['message'],
        //   snackPosition: SnackPosition.TOP,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        //   forwardAnimationCurve: Curves.elasticInOut,
        //   reverseAnimationCurve: Curves.easeOut,
        // );
      }
    } catch (e) {
      print(e);
    }
    return ListEvents;
  }

  Future<List<EventDetails>> getDetailsEvenement(int EvenementID) async {
    List<EventDetails> eventDetails = [];

    var response = await http
        .get(Uri.parse(Api.getDetailsEvenement(EvenementID)), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    try {
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        List<dynamic> eventList = responseBody;
        eventDetails = eventList.map((eventJson) => EventDetails.fromJson(eventJson)).toList();
        // for (var item in responseBody) {
        //   eventDetails.add(EventDetails.fromJson(item));
        //   // inspect(eventDetails);
        // }
      } else {
        isLoading.value = false;
        print('Erreur lors de la récupération des détails de l\'événement');
      }
    } catch (e) {
      print('Erreur lors de la récupération des détails de l\'événement: $e');
    }

    return eventDetails;
  }
}
