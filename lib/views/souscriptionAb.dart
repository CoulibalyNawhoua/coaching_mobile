import 'package:app_coaching/views/categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constantes/constantes.dart';
import '../controllers/AbonnementController.dart';

class SouscriptionAbonnementPage extends StatefulWidget {
  final String url;
  final String transactionId;
  final int paiementId;
  final int souscriptionId;
  const SouscriptionAbonnementPage({super.key, required this.url, required this.transactionId, required this.paiementId, required this.souscriptionId});

  @override
  State<SouscriptionAbonnementPage> createState() => _SouscriptionAbonnementPageState();
}

class _SouscriptionAbonnementPageState extends State<SouscriptionAbonnementPage> {
  late WebViewController controller;
  final AbonnementController abonnementController = Get.put(AbonnementController());


  Future<void> onClearCookies(BuildContext context) async {
    await WebViewCookieManager().clearCookies();
  }

  Future<void> onClearCache(BuildContext context) async {
    await WebViewController().clearCache();
    await WebViewController().clearLocalStorage();
  }

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
      abonnementController.checkPayment(widget.transactionId,widget.paiementId,widget.souscriptionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: Text(
          "Guichet paiement",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.to(() => Categorie());
          },
        )
        // iconTheme: IconThemeData(color: Colors.white),
      ),
       body: Center(
        child: WebViewWidget(controller: controller)
       ),
    );
  }
}
