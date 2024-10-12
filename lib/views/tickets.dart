
import 'dart:developer';

import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_constante.dart';
import '../controllers/Ticket.dart';
import '../controllers/auth.dart';

class TicketPage extends StatefulWidget {
  final int dateId;

  TicketPage({required this.dateId, Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final TicketEvenementController ticketEventController = Get.put(TicketEvenementController());
  final AuthenticateController authenticateController = Get.put(AuthenticateController());

  _formatHeure(String heureEvenement) {
    final heuresMinutes = heureEvenement.split(':');
    final heures = int.parse(heuresMinutes[0]);
    final minutes = int.parse(heuresMinutes[1]);
    final heureFormatee =
        '${heures.toString().padLeft(2, '0')}H${minutes.toString().padLeft(2, '0')}';
    return heureFormatee;
  }

  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    isMounted = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await authenticateController.checkTokenExpiration(isMounted);
     
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
  //   dateId = widget.dateId;
  // }

  //   @override
  // void initState() {
  //   super.initState();
  //   dateId = widget.dateId;
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
        title: Text(
          "Tickets",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: ticketEventController.getTicketEvent(widget.dateId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Afficher un indicateur de chargement pendant le chargement des données.
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      // Afficher un message d'erreur si une erreur s'est produite.
                      return Text('Erreur: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Gérer le cas où les données sont null ou inexistantes.
                      return Center(child: Text('Les tickets ne sont pas disponibles.'));
                    } else {
                      var tickets = snapshot.data!;
                      return Stack(
                        children: [
                          Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Column(
                              //     children: tickets.map((ticket) {
                              //       return Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             "${ticket.dateEvenement}",
                              //             style: TextStyle(
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 20,
                              //             ),
                              //           ),
                              //           ElevatedButton(
                              //             onPressed: (() {}),
                              //             style: ElevatedButton.styleFrom(
                              //               backgroundColor: Colors.white,
                              //               shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(10),
                              //               ),
                              //             ),
                              //             child: Text(
                              //               '${_formatHeure(ticket.heureEvenement)}',
                              //               style: TextStyle(
                              //                 fontWeight: FontWeight.bold,
                                              
                              //                 color: AppColors.primaryColor,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                              
                              Expanded(
                                child: ListView.builder(
                                  itemCount: tickets.length,
                                  itemBuilder: ((context, index) {
                                    var ticket = tickets[index];
                                    GlobalKey<TicketCardState> cardKey = GlobalKey<TicketCardState>();
                                      return TicketCard(
                                        titre: ticket.eventTitle,
                                        date: ticket.dateEvenement,
                                        heure: ticket.heureEvenement,
                                        lieu: ticket.adresseEvent,
                                        prix: ticket.prixTickets.toString(),
                                        image:  "${Api.imageUrl}${ticket.eventImage}",
                                        type: ticket.libelle,
                                        key: cardKey,
                                        onPressed: () async {
                                          var cardState = cardKey.currentState;
                                          if (cardState != null) {
                                            var quantity = cardState.getQuantity();
                                            // await TicketEventController.verifyTicketQuantity(ticket.id, quantity);
                                            var data = {
                                              'quantity': quantity,
                                              'id_tickets': ticket.id,
                                              // 'dateId': widget.dateId,
                                              // 'date_evenement': ticket.dateEvenement,
                                              // 'heure_evenement': ticket.heureEvenement,
                                              // 'adresse_event': ticket.adresseEvent,
                                            };
                                            await ticketEventController.verifyTicketQuantity(data);
                                            // Get.to(AchatTicket(data: data));
                                            // route(context, AchatTicket( data: data));
                                          }
                                        },
                                      );
                                
                                        })
                                      ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
