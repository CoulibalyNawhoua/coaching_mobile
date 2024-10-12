import 'dart:convert';

import 'package:app_coaching/api/api_constante.dart';
import 'package:app_coaching/models/citation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CitationController extends GetxController {
  final isLoading = false.obs;
  final token = GetStorage().read("access_token");

  // @override
  // void onInit() {
  //   getCitation();
  //   super.onInit();
  // }

  Future<List<CitationModel>> getCitation() async {
    List<CitationModel> ListCitation = [];

    var response = await http.get(Uri.parse(Api.Citations), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    try {
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = json.decode(response.body)["data"];

        for (var item in responseBody) {
          if (item is Map<String, dynamic>) {
            ListCitation.add(CitationModel.fromJson(item));
          } else {
            print("echec");
          }
        }

      }
    } catch (e) {
      print(e);
    }
    return ListCitation;
  }

  Future<List<CitationModel>> getCitationCategorie(categorieID) async {
    List<CitationModel> ListCitationsCategorie = [];

    var response = await http
        .get(Uri.parse(Api.citationsCategorie(categorieID)), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    try {
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body)["data"];
        for (var item in responseBody) {
          if (item is Map<String, dynamic>) {
            ListCitationsCategorie.add(CitationModel.fromJson(item));
          } else {
            print("echec");
          }
        }
        
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
    return ListCitationsCategorie;
  }



}
