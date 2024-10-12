import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../api/api_constante.dart';
import '../models/user.dart';

class UserController extends GetxController {
  final isLoading = false.obs;
  final token = GetStorage().read("access_token");
  // final user = Rx<User?>(null);

  // Future<User?> getUserInfo() async {

  //     isLoading.value = true;
  //     var response = await http.get(
  //       Uri.parse(Api.userInfos),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       var responseData = json.decode(response.body)['user_infos'];
  //       var userInfo = User.fromJson(responseData);
  //       isLoading.value = false;
  //       return userInfo;
  //     } else {
  //       isLoading.value = false;
  //       print('Failed to load user info');
  //     }
   
  // }
  Future<User?> getUserInfo() async {
    isLoading.value = true;
    try {
      var response = await http.get(
        Uri.parse(Api.userInfos),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body)['user_infos'];
        var userInfo = User.fromJson(responseBody);
        isLoading.value = false;
        return userInfo;
      } else {
        isLoading.value = false;
        print('Failed to load user info');
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching user info: $e');
      return null;
    }
  }
  

  Future<void> UpdateProfile({
    required int userId,
    required String firstName,
    required String lastName,
    String? email,
    String? adresse,
    String? genre,
    String? imageUrl,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email ?? "",
        'adresse': adresse ?? "",
        'genre': genre ?? "",
        'url_photo': imageUrl ??"",
      };
      
      // var response = await http.post(
      //   Uri.parse(Api.updateUserProfile(userId)),
      //   headers: {
      //     'Accept': 'application/json',
      //     'Authorization': 'Bearer $token',
      //     'Content-Type': 'multipart/form-data',
      //   },
      //   body: data,
      // );
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      };

      // var request = http.MultipartRequest(
      //     'POST', Uri.parse(Api.updateUserProfile(userId)))
      //   ..fields.addAll(data)
      //   ..headers.addAll(headers)
      //   ..files.add(await http.MultipartFile.fromPath(
      //       'url_photo', imageUrl.toString()));

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Api.updateUserProfile(userId)),
      );

      request.headers.addAll(headers);
      request.fields.addAll(data);
      if (imageUrl != null && imageUrl.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'url_photo',
          imageUrl,
        ));
      }
 
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar(
          'Mise à jour : ',
          json.decode(responseData)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

         var updatedUserInfo = await getUserInfo();
         
          if (updatedUserInfo != null) {
            await GetStorage().write("user_info", updatedUserInfo.toJson());
          }

        // var responseBody = json.decode(responseData)['user_infos'];
        // var updatedUserInfo = User.fromJson(responseBody);
        // // inspect(updatedUserInfo);
        // await GetStorage().write("user_infos", updatedUserInfo.toJson());
      } else {
        isLoading.value = false;

        if (kDebugMode) {
          print(json.decode(responseData));
        }
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
