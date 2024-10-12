import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String titre;
  final String date;
  final String lieu;
  final String prix;
  final String image;
  final VoidCallback onPressed;

  const EventCard({
    required this.titre,
    required this.date,
    required this.lieu,
    required this.prix,
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
              height: height(context) * 0.02,
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: height(context) * 0.25,
                        width: width(context),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular((5)),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: height(context) * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titre,
                            style: TextStyle(
                              fontSize: height(context) * 0.03,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
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
                                      Text(
                                        lieu,
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          // fontSize: 12,
                                        ),
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
                                      Text(
                                        date,
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 6),
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  prix,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                      
                    ],
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
