import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String titre;
  final String date;
  final String heure;
  final String lieu;
  final Widget image;
  final VoidCallback onPressed;

  const EventCard({
    required this.titre,
    required this.date,
    required this.heure,
    required this.lieu,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height:
                        height(context) * 0.23, // Ajustez la hauteur de l'image
                    width: double.infinity,
                    child: image,
                  ),

                  SizedBox(height: 10), // Espace supplémentaire
                  Text(
                    titre,
                    style: TextStyle(
                      fontSize: height(context) * 0.03,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  // SizedBox(height: 10), // Espace supplémentaire
                  Padding(
                    padding: EdgeInsets.only(top: height(context) * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  lieu,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  date, 
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(";"),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  heure,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Container(
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        //   decoration: BoxDecoration(
                        //       color: AppColors.secondaryColor,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Text(
                        //     prix,
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.w500,
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
