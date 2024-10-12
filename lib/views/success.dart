// import 'package:app_coaching/constantes/constantes.dart';
// import 'package:app_coaching/fonctions/fonction.dart';
// import 'package:app_coaching/views/abonnement.dart';
// import 'package:app_coaching/widgets/button.dart';
// import 'package:app_coaching/widgets/profil_clipper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../api/api_constante.dart';
// import '../controllers/AbonnementController.dart';
// import '../controllers/UserController.dart';
// import '../controllers/auth.dart';

// class UserAbonnement extends StatefulWidget {
//   const UserAbonnement({super.key});

//   @override
//   State<UserAbonnement> createState() => _UserAbonnementState();
// }

// class _UserAbonnementState extends State<UserAbonnement> {
//   final AuthenticateController authenticateController =
//       Get.put(AuthenticateController());
//   final AbonnementController abonnementController =
//       Get.put(AbonnementController());
//   final UserController userController = Get.put(UserController());

//   bool isMounted = false;

//   @override
//   void initState() {
//     super.initState();
//     isMounted = true;
//     WidgetsBinding.instance!.addPostFrameCallback((_) async {
//       await authenticateController.checkTokenExpiration(isMounted);
//       await abonnementController.checkAbonnement();
//       await userController.getUserInfo();
//       await abonnementController.getAbonnementUtilisateur();
//     });
//   }

//   @override
//   void dispose() {
//     isMounted = false;
//     super.dispose();
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getUserData();
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //      authenticateController.checkTokenExpiration();
//   //     // if (mounted) {
//   //     //   authenticateController.checkAccessToken();

//   //     // }
//   //   });
//   // }

//   String formatPrice(String montant) {
//     final currencyFormatter = NumberFormat("#,##0 F", "fr_FR");
//     return currencyFormatter.format(double.parse(montant));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryColor,
//         title: Text("Mon Abonnement", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         elevation: 0.0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             // Get.to(() => Base());
//             Get.back();
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // if (userInfo != null)
//             FutureBuilder(
//               future: userController.getUserInfo(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else if (snapshot.data == null) {
//                   return Text('No data available');
//                 } else {
//                   final user = snapshot.data!;
//                   return ClipperCustom(
//                     image: user.urlPhoto != null
//                         ? "${Api.imageUrl}${user.urlPhoto}"
//                         : "assets/images/ai-generated-8083323_1280.jpg",
//                     name: user.firstName + ' ' + user.lastName,
//                     phone: user.email ?? user.phone,
//                   );
//                 }
//               },
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: height(context) * 0.03),
//               child: Column(
//                 children: [
//                   Container(
//                     height: height(context) * 0.1,
//                     width: width(context) * 0.8,
//                     decoration: BoxDecoration(
//                       color: AppColors.secondaryColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Souscription: prix_abonnements/ periode",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Offres de l'abonnement",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),

//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // SizedBox(height: 8),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: 4,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Row(
//                               children: [
//                                 Icon(
//                                   Icons.done,
//                                   color: Colors.green,
//                                 ),
//                                 SizedBox(width: 10),
//                                 Text(
//                                   'offres',
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Afficher le bouton de souscription si l'utilisateur n'a pas d'abonnement
//                   if (!abonnementController.hasSubscription.value)
//                     Padding(
//                       padding: EdgeInsets.only(top: height(context) * 0.25),
//                       child: CButton(
//                           title: "Souscription",
//                           onPressed: () {
//                             // Afficher le modal bottom sheet avec les abonnements
//                             showModalBottomSheet(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AbonnementPage();
//                               },
//                             );
//                           }),
//                       // child: ElevatedButton(
//                       //   onPressed: () {
//                       //     if (abonnementInfo == null || abonnementInfo.abonnement.id == 0) {
//                       //       // Afficher le modal bottom sheet avec les abonnements
//                       //       showModalBottomSheet(
//                       //         context: context,
//                       //         builder: (BuildContext context) {
//                       //           return AbonnementPage();
//                       //         },
//                       //       );
//                       //     }
//                       //   },
//                       //   child: Text(
//                       //     "Souscription",
//                       //     style: TextStyle(color: Colors.white),
//                       //   ),
//                       //   style: ButtonStyle(
//                       //     shape: MaterialStateProperty.all(
//                       //       RoundedRectangleBorder(
//                       //         borderRadius: BorderRadius.circular(10),
//                       //       ),
//                       //     ),
//                       //     backgroundColor: MaterialStateProperty.all<Color>(
//                       //       AppColors.primaryColor,
//                       //     ),
//                       //   ),
//                       // ),
//                     ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
