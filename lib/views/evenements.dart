import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/controllers/EventController.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/views/details_event.dart';
import 'package:app_coaching/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../api/api_constante.dart';
import '../controllers/Ticket.dart';
import '../controllers/auth.dart';

class Evenement extends StatefulWidget {
  const Evenement({super.key});

  @override
  State<Evenement> createState() => _EvenementState();
}

class _EvenementState extends State<Evenement> {
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  //  final TicketEvenementController ticketEventController = Get.put(TicketEvenementController());
  final EventController = Get.put(EvenementController());
  bool isLoading = false;
  bool isMounted = false;
  
  _formatHeure(String heureEvenement) {
    final heuresMinutes = heureEvenement.split(':');
    final heures = int.parse(heuresMinutes[0]);
    final minutes = int.parse(heuresMinutes[1]);
    final heureFormatee =
        '${heures.toString().padLeft(2, '0')}H${minutes.toString().padLeft(2, '0')}';
    return heureFormatee;
  }
  

  @override
  void initState() {
    super.initState();
    isMounted = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await authenticateController.checkTokenExpiration(isMounted);
      // await ticketEventController.getTicket();
    });
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: Text(
          "Evènements",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                  future: EventController.getEvenement(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Erreur: ${snapshot.error}');
                      
                    }else if (!snapshot.hasData || snapshot.data!.isEmpty){
                      return Center(
                        child: Text('Aucun évènements disponible'),
                      );
                    } else {
                      var events = snapshot.data;
                      return ListView.builder(
                        itemCount: events?.length,
                        itemBuilder: (context, index) {
                          var evenement = events![index];
                          return EventCard(
                            titre: evenement.titre,
                            // image: "${Api.imageUrl}${evenement.urlImage}",
                            image: "${Api.imageUrl}${evenement.urlImage}",
                            premiereDate: "${DateFormat('dd MMMM yyyy','fr_FR').format(evenement.premiereDate)}",
                            premiereHeure: "${_formatHeure(evenement.heurePremiereDate)}",
                            derniereDate: "${DateFormat('dd MMMM yyyy','fr_FR').format(evenement.derniereDate)}",
                            derniereHeure: "${_formatHeure(evenement.heureDerniereDate)}",
                            onPressed: () {
                              route(context,DetailEvent(EvenementID: evenement.id));
                            },
                          );
                          
                        }
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
