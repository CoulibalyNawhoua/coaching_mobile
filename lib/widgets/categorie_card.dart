import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/AbonnementController.dart';


class CategorieCard extends StatefulWidget {
  final String name;
  final VoidCallback onTap;

   CategorieCard(
      {required this.name,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  State<CategorieCard> createState() => _CategorieCardState();
}

class _CategorieCardState extends State<CategorieCard> {
  final AbonnementController abonnementController = Get.put(AbonnementController());

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        child: Container(
          width: width(context) * 0.5,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    // fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                // Icon(Icons.lock, size: 16)
                  Obx(() {
                  // Conditionally show lock icon based on subscription status
                  if (abonnementController.hasSubscription.value && abonnementController.expired.value) {
                    return SizedBox();
                  } else {
                    return Icon(Icons.lock, size: 16);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
