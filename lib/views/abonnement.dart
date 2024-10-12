
import 'package:app_coaching/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constantes/constantes.dart';
import '../controllers/AbonnementController.dart';
import '../controllers/auth.dart';

class AbonnementPage extends StatefulWidget {
  const AbonnementPage({super.key});

  @override
  State<AbonnementPage> createState() => _AbonnementPageState();
}

class _AbonnementPageState extends State<AbonnementPage> {
  final AbonnementController abonnementController = Get.put(AbonnementController());
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  // late int  selectedAbonnementId = abonnementController.listAbonnement.first.id; 
  late int  selectedAbonnementId = 2; 
  bool isMounted = false;

     

  String formatPrice(String montant) {
    final currencyFormatter = NumberFormat("#,##0 F", "fr_FR");
    return currencyFormatter.format(double.parse(montant));
  }

  @override
  void initState() {
    super.initState();
    isMounted = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await authenticateController.checkTokenExpiration(isMounted);
    });
    abonnementController.getAbonnement();
      abonnementController.getOffresByAbonnement(selectedAbonnementId);
      if (abonnementController.listAbonnement.isNotEmpty) {
        setState(() {
          selectedAbonnementId = abonnementController.listAbonnement.first.id;
      });
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }
  
    // WidgetsBinding.instance.addPostFrameCallback((_)async {
    //   if (mounted) {
    //     authenticateController.checkAccessToken();
    //   }
    //   await abonnementController.getAbonnement();
    //   await abonnementController.getOffresByAbonnement(selectedAbonnementId);
    //     // Sélectionner le premier abonnement par défaut s'il y en a
    //     if (abonnementController.listAbonnement.isNotEmpty) {
    //       setState(() {
    //         selectedAbonnementId = abonnementController.listAbonnement.first.id;
    //       });
    //     }
        
    // });
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: ClipOval(child: Image.asset("assets/images/logo.png")),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          Column(
            children: [
            Obx(() {
              var libelle = abonnementController.libelle.value;
              var offres = abonnementController.offres;
              return Column(
                children: [
                  Text(
                    libelle,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Affichage des offres
                  Column(
                    children: offres.map((offre) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            offre.offres,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              );
            }),
          ],
        ),
          // const SizedBox(height: 20),
        SizedBox(
          height: 120,
          child: Obx(() {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: abonnementController.listAbonnement.length,
              separatorBuilder: (context, index) => SizedBox(width: 20),
              itemBuilder: (BuildContext context, int index) {
                var abonnement = abonnementController.listAbonnement[index];
                return AbonnementContainer(
                  id: abonnement.id,
                  price: abonnement.prixAbonnements,
                  periode: abonnement.periode,
                  isSelected: abonnement.id == selectedAbonnementId,
                  onTap: () async {
                    setState(() {
                        selectedAbonnementId = abonnement.id;
                    });
                    await abonnementController.getOffresByAbonnement(abonnement.id);
                  },
                );
              },
            );
          }),
        ),
        ElevatedButton(
          onPressed: () async {
            await abonnementController.SouscriptionAbonnement(selectedAbonnementId, abonnementController.listAbonnement
              .firstWhere((abonnement) => abonnement.id == selectedAbonnementId)
              .prixAbonnements);
          },
          
          child: Obx(() {
            return abonnementController.isLoading.value
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
        // CButton(
        //   title: "Passer au paiement", 
        //   onPressed: () async {
        //     await abonnementController.SouscriptionAbonnement(selectedAbonnementId, abonnementController.listAbonnement
        //         .firstWhere((abonnement) => abonnement.id == selectedAbonnementId)
        //         .prixAbonnements);
        //   },
        // ),
        ],
      ),
    );
  }
}

class AbonnementContainer extends StatelessWidget {
  final int id;
  final String price;
  final String periode;
  final bool isSelected;  
  final VoidCallback onTap;

  const AbonnementContainer({
    super.key,
    required this.id,
    required this.price,
    required this.periode,
    required this.isSelected,
    required this.onTap,
  });

  String formatPrice(String montant) {
    final currencyFormatter = NumberFormat("#,##0 F", "fr_FR");
    return currencyFormatter.format(double.parse(montant));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: isSelected ? AppColors.secondaryColor : AppColors.primaryColor, // Changer la couleur en fonction de isSelected
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  formatPrice(price),
                  style: const TextStyle(
                    // fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  periode,
                  style: const TextStyle(
                    // fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AbonnementOffres extends StatelessWidget {
  final String offre;
  final String categorie;

  const AbonnementOffres({
    super.key,
    required this.offre,
    required this.categorie,
  });

  String formatPrice(String montant) {
    final currencyFormatter = NumberFormat("#,##0 F", "fr_FR");
    return currencyFormatter.format(double.parse(montant));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          categorie,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Icon(
              Icons.done,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            Text(
              offre,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
