// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app_coaching/controllers/Ticket.dart';
import 'package:app_coaching/views/evenements.dart';
import 'package:app_coaching/widgets/base.dart';
import 'package:get/get.dart';

import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:app_coaching/constantes/constantes.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../api/api_constante.dart';
import '../models/ticket.dart';


class MyTicket extends StatefulWidget {
  
  TicketInfo ticketInfo;
  MyTicket({Key? key, required this.ticketInfo}) : super(key: key);

  @override
  State<MyTicket> createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  final TicketEvenementController getTicket = Get.put(TicketEvenementController());

   _formatHeure(String heureEvenement) {
    final heuresMinutes = heureEvenement.split(':');
    final heures = int.parse(heuresMinutes[0]);
    final minutes = int.parse(heuresMinutes[1]);
    final heureFormatee =
        '${heures.toString().padLeft(2, '0')}H${minutes.toString().padLeft(2, '0')}';
    return heureFormatee;
  }

  String formatPrice(String price) {
    final currencyFormatter = NumberFormat("#,##0 F", "fr_FR");
    return currencyFormatter.format(double.parse(price));
  }
     

  // Créer une GlobalKey pour RepaintBoundary:Ce widget crée une liste d'affichage
  final GlobalKey key = GlobalKey();
  // Fonction pour convertir un widget en image
  Future<Uint8List> captureWidgetToImage() async {
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8List = byteData!.buffer.asUint8List();
    return uint8List;
  }

  // Fonction pour sauvegarder l'image localement
  Future<File> saveImage(Uint8List uint8List) async {
    Directory directory = await getTemporaryDirectory();
    String path = directory.path;
    File imageFile = File('$path/ticket_event_ebora.png');

    await imageFile.writeAsBytes(uint8List);
    return imageFile;
  }

  // Save image to gallery
  Future<void> saveImageToGallery(File imageFile) async {
    await GallerySaver.saveImage(imageFile.path, albumName: 'MyTickets');
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: Text(
          "Mon ticket",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.to(() => Evenement());
          },
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Télécharger votre ticket ci-dessous ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Container(
              child: Builder(
                builder: (context) => RepaintBoundary(
                  // Utiliser la GlobalKey pour RepaintBoundary
                  key: key,
                  child: Column(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: TicketWidget(
                          width: 200,
                          height: 350,
                          isCornerRounded: true,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 20,
                                  child: ClipPath(
                                    clipper: CustomClipDesign(),
                                    child: Container(
                                      height: 50,
                                      width: 28,
                                      alignment: Alignment.topCenter,
                                      color: AppColors.primaryColor,
                                      child: Text(
                                        "${DateFormat('dd \n MMM', 'fr_FR').format(DateTime.parse(widget.ticketInfo.dateEvenement))}",
                                        // "25 \n oct",
                                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  )
                                ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage("${Api.imageUrl}${widget.ticketInfo.urlImages}"),
                                      // backgroundImage: Image.asset("${Api.imageUrl}${widget.ticketInfo.urlImages}"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.ticketInfo.titles,
                                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14, ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                          size: 10,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.ticketInfo.adresseEvent,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Heure",
                                              style: TextStyle(fontWeight:  FontWeight.w700),
                                            ),
                                            Text(
                                              "${_formatHeure(widget.ticketInfo.heureEvenement)}",
                                              style: TextStyle( fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Prix",
                                              style: TextStyle(fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              "${formatPrice(widget.ticketInfo.prixTickets.toString())}",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    QrImageView(
                                      data: widget.ticketInfo.referencesTickets,
                                      size: 100.0,
                                      version: QrVersions.auto,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  // Capture et sauvegarde de l'image
                  Uint8List uint8List = await captureWidgetToImage();
                  File file = await saveImage(uint8List);
                  // Save to gallery
                  await saveImageToGallery(file);
                  // Convert the file path to XFile
                  XFile xFile = XFile(file.path);

                  setState(() {
                    // Update the UI to trigger repaint
                  });

                  // Partage de l'image
                  Share.shareXFiles([xFile]);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Télécharger",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ],
        ),
              
          
      ),
    );
  }
}

class CustomClipDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double h = size.height;
    double w = size.width;

    path.lineTo(0, h - 15);
    path.lineTo(w / 4, h);
    path.lineTo(w / 2, h - 15);
    path.lineTo(w / 1.3, h);
    path.lineTo(w, h - 15);
    path.lineTo(w, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
