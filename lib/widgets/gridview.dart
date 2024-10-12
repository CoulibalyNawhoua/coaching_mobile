import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/widgets/base.dart';
import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
 const GridCard({required this.title, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          route(context, Base());
        },
        child: Container(
          width: width(context) *0.5,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                
              ],
            ),
          ),
        ),
        
        borderRadius: BorderRadius.circular(50),
            
      ),
    );
  }
  
}