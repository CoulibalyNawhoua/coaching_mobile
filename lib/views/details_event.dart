import 'package:app_coaching/api/api_constante.dart';
import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/views/tickets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/EventController.dart';
import '../controllers/auth.dart';
import '../models/event.dart';

class DetailEvent extends StatefulWidget {
  final int EvenementID;
  const DetailEvent({required this.EvenementID, Key? key}) : super(key: key);

  @override
  State<DetailEvent> createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final EvenementController DetailsController = Get.put(EvenementController());
      
  bool showMore = false;
  get longText => null;

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
  //   @override
  // void initState() {
  //   super.initState();
  //   // EvenementID = widget.EvenementID;
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (!mounted) {
  //      authenticateController.checkTokenExpiration();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Détails évènement",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: AppColors.primaryColor,
      //   elevation: 0.0,
      //   iconTheme: const IconThemeData(
      //     color: Colors.white,
      //   ),
      // ),
      body: Column(
          children: [
            FutureBuilder(
                future: DetailsController.getDetailsEvenement(widget.EvenementID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Aucun détail d\'événement trouvé.');
                  } else {
                    // final detailsEvent = snapshot.data!
                    var detailsEvent = snapshot.data![0];
                    return Column(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                width: width(context),
                                height: height(context) * 0.4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${Api.imageUrl}${detailsEvent.urlImages}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                          // Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        )),
                                    
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(
                                    //     Icons.favorite_border,
                                    //     color: Colors.white,
                                    //   )
                                    // )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                height: 400,
                                width: width(context),
                                margin: EdgeInsets.only(top: height(context) * 0.33),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)
                                  )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${detailsEvent.titles}",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 10.0,),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: detailsEvent.datesEvenement.length,
                                            itemBuilder: (context, index) {
                                              EventDate eventDate = detailsEvent.datesEvenement[index];
                                              return EventItem(
                                                dateEvent: DateFormat('dd MMMM yyyy','fr_FR').format(eventDate.dateEvenement),
                                                heure: eventDate.heureEvenement,
                                                adresse: eventDate.adresseEvent,
                                                onPressed: () {
                                                  Get.to(TicketPage(dateId: eventDate.id));
                                                },
                                              );
                                            },
                                          ),
                                          SizedBox(height: 20.0), // Espacement entre les deux éléments
                                          Text(
                                            "${detailsEvent.descriptions}",
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                                
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      
    );
  }
}

class EventItem extends StatelessWidget {
  String dateEvent;
  String heure;
  String adresse;
  VoidCallback onPressed;

  EventItem(
      {super.key,
      required this.dateEvent,
      required this.heure,
      required this.adresse,
      required this.onPressed});

  String formatHeure(String heureEvenement) {
    final heuresMinutes = heureEvenement.split(':');
    final heures = int.parse(heuresMinutes[0]);
    final minutes = int.parse(heuresMinutes[1]);
    final heureFormatee =
        '${heures.toString().padLeft(2, '0')}H${minutes.toString().padLeft(2, '0')}';
    return heureFormatee;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: AppColors.primaryColor,
                        size: 10,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "$dateEvent ; ${formatHeure(heure)}",
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: AppColors.primaryColor,
                        size: 12,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "${adresse}",
                      style: TextStyle(color: Colors.grey[500], 
                          // fontSize: 12,
                          ),
                    ),
                  ],
                ),
               
              ],
            ),
            TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "ticket",
                  style: TextStyle(color: Colors.white),
                ))
        
            // ElevatedButton(
            //     onPressed: onPressed,
            //     child: Text(
            //       'Ticket',
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ))
          ],
        ),
         Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 15,
                thickness: 1,
                color: Colors.grey.shade300,
              ),
            ),
      ],
    );
  }
}
