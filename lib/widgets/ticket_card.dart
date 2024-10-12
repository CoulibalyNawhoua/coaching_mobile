import 'package:app_coaching/constantes/constantes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketCard extends StatefulWidget {
  final String titre;
  final String date;
  final String heure;
  final String lieu;
  final String prix;
  final String image;
  final String type;
  final VoidCallback onPressed;

  TicketCard({
    //  super.key,
    required this.titre,
    required this.date,
    required this.heure,
    required this.lieu,
    required this.prix,
    required this.image,
    required this.type,
    required this.onPressed,
    required Key key,
  }) : super(key: key);
  @override
  TicketCardState createState() => TicketCardState();
}

class TicketCardState extends State<TicketCard> {
  
  _formatHeure(String heureEvenement) {
    final heuresMinutes = heureEvenement.split(':');
    final heures = int.parse(heuresMinutes[0]);
    final minutes = int.parse(heuresMinutes[1]);
    final heureFormatee =
        '${heures.toString().padLeft(2, '0')}H${minutes.toString().padLeft(2, '0')}';
    return heureFormatee;
  }

  String formatPrice(String montant) {
    final currencyFormatter = NumberFormat("#,##0 FCFA", "fr_FR");
    return currencyFormatter.format(double.parse(montant));
  }

  int quantity = 1; // L'état local pour la quantité

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  // Fonction de rappel pour renvoyer la valeur de quantity
  int getQuantity() {
    return quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 40,
                color: AppColors.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.type,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      formatPrice(widget.prix),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                        height: 70,
                        width: 70,
                        child: Image.network(widget.image, fit: BoxFit.cover),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            widget.titre,
                            maxLines: 2,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${DateFormat('dd MMMM yyyy', 'fr_FR').format(DateTime.parse(widget.date))} ;  ${_formatHeure(widget.heure)}",
                                // widget.date,
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 12),
                              ),
                              Text(
                                widget.lieu,
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      )
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
                            onPressed: () {
                              decrementQuantity();
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              size: 20,
                            )),
                        Text(
                          quantity.toString(),
                        ),
                        IconButton(
                            onPressed: () {
                              incrementQuantity();
                            },
                            icon: Icon(
                              Icons.add_circle,
                              size: 20,
                            ))
                      ],
                    ),
                    ElevatedButton(
                        onPressed: widget.onPressed,
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          "Acheter",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
