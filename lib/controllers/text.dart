// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// import '../api/api_constante.dart';
// import '../models/user.dart';

// class UserController extends GetxController {
//   final isLoading = false.obs;
//   final token = GetStorage().read("access_token");

//   Future<void> UpdateProfile({
//     required int userId,
//     required String firstName,
//     required String lastName,
//     required String phone,
//     String? adresse,
//     String? genre,
//     String? email,
//     String? imageUrl,
//   }) async {
//     try {
//       isLoading.value = true;
//       var data = {
//         'first_name': firstName,
//         'last_name': lastName,
//         'phone': phone,
//         'email': email ?? '',
//         'adresse': adresse ?? '',
//         'genre': genre ?? '',
//         'url_photo': imageUrl ?? '',
//       };

//       // inspect(data);
//       // var response = await http.put(
//       //   Uri.parse(Api.updateUserProfile(userId)),
//       //   headers: {
//       //     'Accept': 'application/json',
//       //     'Authorization': 'Bearer $token',
//       //   },
//       //   body: data,
//       // );

//       Map<String, String> headers = {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'multipart/form-data',
//       };

//       var request = http.MultipartRequest('PUT', Uri.parse(Api.updateUserProfile(userId)))
//       ..fields.addAll(data)
//       ..headers.addAll(headers)
//       ..files.add(await http.MultipartFile.fromPath('url_photo', imageUrl.toString()));


//       var response = await request.send();
//       var responseData = await response.stream.bytesToString();
//       // var jsonResponse = json.decode(responseData);
//       if (response.statusCode == 200) {
//         isLoading.value = false;
//         Get.snackbar(

//           'Mise à jour : ',
//           json.decode(responseData)['message'],
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );

//         var responseBody = json.decode(responseData)['user_infos'];
//         var updatedUserInfo  = User.fromJson(responseBody);
//         await GetStorage().write("user_infos", updatedUserInfo.toJson());
//         //  this.userInfo = updatedUserInfo;
//       } else {
//         isLoading.value = false;

//         if (kDebugMode) {
//           print(json.decode(responseData));
//         }
//       }
//     } catch (e) {
//       isLoading.value = false;
//       print(e.toString());
//     }
//   }
// }