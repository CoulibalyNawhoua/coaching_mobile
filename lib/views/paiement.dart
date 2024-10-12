
import 'package:app_coaching/views/evenements.dart';
import 'package:app_coaching/views/ticket.dart';
import 'package:app_coaching/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constantes/constantes.dart';
import '../controllers/Ticket.dart';

class Paiement extends StatefulWidget {
  final String url;
  final String transactionId;
  final int paiementId;
  final int achatTicketId;
  Paiement({super.key, required this.url, required this.transactionId, required this.paiementId, required this.achatTicketId});

  @override
  State<Paiement> createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {
  late WebViewController controller;

  Future<void> onClearCookies(BuildContext context) async {
    await WebViewCookieManager().clearCookies();
  }

  Future<void> onClearCache(BuildContext context) async {
    await WebViewController().clearCache();
    await WebViewController().clearLocalStorage();
  }

  final TicketEvenementController paiementController = Get.put(TicketEvenementController());
      
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
      paiementController.checkPayment(widget.transactionId, widget.paiementId, widget.achatTicketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: Text(
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
      body: Center(
        child: WebViewWidget(controller: controller)
      ),
    );
  }
}
