import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String titre;
  final String premiereDate;
  final String premiereHeure;
  final String derniereDate;
  final String derniereHeure;
  final String image;
  final VoidCallback onPressed;

  const EventCard({
    required this.titre,
    required this.image,
    required this.premiereDate,
    required this.premiereHeure,
    required this.derniereDate,
    required this.derniereHeure,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // final formattedDates = _formatDates();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Row(
            children: [
              Image.network(
                // "${Api.imageUrl}/${detailsTicket.eventImage}",
                image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: onPressed,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titre,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        premiereDate == derniereDate
                            ? "Le $premiereDate à $premiereHeure"
                            : "Du $premiereDate à $premiereHeure",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      if (premiereDate != derniereDate)
                        Text(
                          "Au $derniereDate à $derniereHeure",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
               
              ),
        
            ],
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
