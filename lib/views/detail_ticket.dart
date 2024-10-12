
import 'dart:developer';

import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/controllers/Ticket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../api/api_constante.dart';
import '../controllers/AbonnementController.dart';
import '../controllers/auth.dart';
import '../fonctions/fonction.dart';
import '../models/ticket.dart';
import 'evenements.dart';

class AchatTicketPage extends StatefulWidget {
  final DetailsTicket ticketDetails;

  AchatTicketPage({Key? key, required this.ticketDetails}) : super(key: key);

  @override
  State<AchatTicketPage> createState() => _AchatTicketPageState();
}

class _AchatTicketPageState extends State<AchatTicketPage> {
  final TicketEvenementController ticketEvenementController = Get.put(TicketEvenementController());
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final AbonnementController abonnementController = Get.put(AbonnementController());
  // bool isLoading = false;

  var dateId;

  // ignore: unused_element
  _formatHeure(String heureEvenement) {
    final heuresMinutes = heureEvenement.split(':');
    final heures = int.parse(heuresMinutes[0]);
    final minutes = int.parse(heuresMinutes[1]);
    final heureFormatee = '${heures.toString().padLeft(2, '0')}H${minutes.toString().padLeft(2, '0')}';
    return heureFormatee;
  }

  String formatPrice(String price) {
    final currencyFormatter = NumberFormat("#,##0 F", "fr_FR");
    return currencyFormatter.format(double.parse(price));
  }

  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    isMounted = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await authenticateController.checkTokenExpiration(isMounted);
      await abonnementController.checkAbonnement();
      // await ticketEvenementController.verifyTicketQuantity(widget.ticketDetails);
    });
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //      authenticateController.checkTokenExpiration();
  //     // if (mounted) {
  //     //   authenticateController.checkAccessToken();
  //     // }
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bodyBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: const Text(
          "Achat de ticket",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.back();
          },
        )
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventItemCard(
                    image: "${Api.imageUrl}${widget.ticketDetails.eventImage}",
                    titre: widget.ticketDetails.eventTitle,
                    adresse: widget.ticketDetails.adresseEvent,
                    date: widget.ticketDetails.dateEvenement,
                    heure: widget.ticketDetails.heureEvenement,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Récapitulatif de la commande",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: height(context) * 0.3,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Type de ticket',
                              style: TextStyle(color: Colors.black45,),
                            ),
                            Text(
                              '${widget.ticketDetails.libelle}',
                              style: TextStyle(color: AppColors.primaryColor,fontSize: 16,),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Prix du ticket',
                              style: TextStyle(color: Colors.black45,),
                            ),
                            Text(
                              formatPrice(widget.ticketDetails.prixTickets),
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantité ticket',
                              style: TextStyle(color: Colors.black45,),
                            ),
                            Text(
                              widget.ticketDetails.quantiteTickets,
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Taux de reduction',
                              style: TextStyle(color: Colors.black45,),
                            ),
                            Text(
                              "${(widget.ticketDetails.tauxReduction * 100).toStringAsFixed(0)}%",
                              style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Montant à payé',
                              style: TextStyle(color: Colors.black45,),
                            ),
                            Text(
                              formatPrice(widget.ticketDetails.montantPaye.toString()),
                              style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async  {
                      var data = {
                        'quantity': widget.ticketDetails.quantiteTickets,
                        'montants_paye': widget.ticketDetails.montantPaye.toString(),
                        'id_tickets': widget.ticketDetails.id,
                      };
                      await ticketEvenementController.AchatTicket(data);
                    },
                   
                    child: Obx(() {
                      return ticketEvenementController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Passer au paiement",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            );
                    }),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(345, 55)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(Evenement());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return Evenement();
                      //     },
                      //   ),
                      // );
                    },
                    child: Text(
                      "Plus evènement".toUpperCase(),
                      style: TextStyle(fontSize: 18, color: AppColors.primaryColor),
                    ),
                    style: ButtonStyle(
                      fixedSize:  MaterialStateProperty.all(Size(345, 55)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(width: 2, color: AppColors.primaryColor),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ), //verifier si la couleur est nul (si oui alors on lui donne la couleur pas defaut)
                    ),
                  ),
                ],
              ),
            ),
          ),
             
             
        ],
      ),
    );
  }
}

class EventItemCard extends StatelessWidget {

  final String image;
  final String titre;
  final String adresse;
  final String date;
  final String heure;

  const EventItemCard(
    {super.key,
    required this.image,
    required this.titre,
    required this.adresse,
    required this.date,
    required this.heure}
  );

  @override
  Widget build(BuildContext context) {

    _formatHeure(String heureEvenement) {
      final heuresMinutes = heureEvenement.split(':');
      final heures = int.parse(heuresMinutes[0]);
      final minutes = int.parse(heuresMinutes[1]);
      final heureFormatee =
          '${heures.toString().padLeft(2, '0')}H${minutes.toString().padLeft(2, '0')}';
      return heureFormatee;
    }

    return Container(
      height: height(context) * 0.15,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          
          Expanded(
            child: ListTile(
              title: Text(
                titre,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        adresse,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${DateFormat('dd MMMM yyyy', 'fr_FR').format(DateTime.parse(date))} ,  ${_formatHeure(heure)}",
                        // "${date} , ${heure}",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Image.network(
            image,
            height: 50,
            width: 70,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
