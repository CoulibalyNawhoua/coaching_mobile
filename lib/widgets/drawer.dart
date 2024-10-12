import 'package:app_coaching/constantes/constantes.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final String titre;
  final String date;
  final String lieu;
  final String prix;
  final String image;
  final String type;
  final VoidCallback onPressed;

  const TicketCard({
    required this.titre,
    required this.date,
    required this.lieu,
    required this.prix,
    required this.image,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            height: 40,
            color: AppColors.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  prix,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                    height: 70,
                    width: 70,
                    // color: Colors.amber,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titre,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          date,
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 14),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          lieu,
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 125.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Quantité",
                  style: TextStyle(color: Colors.black),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_circle,
                          size: 20,
                        )),
                    Text(
                      "1",
                      // style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle,
                          size: 20,
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
