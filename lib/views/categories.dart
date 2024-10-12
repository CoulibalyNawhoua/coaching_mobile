
import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/models/categorie_citation.dart';
import 'package:app_coaching/views/abonnement.dart';
import 'package:app_coaching/widgets/base.dart';
import 'package:app_coaching/widgets/categorie_card.dart';
import 'package:flutter/material.dart';
import 'package:app_coaching/controllers/CategorieController.dart';
import 'package:get/get.dart';

import '../controllers/AbonnementController.dart';
import '../controllers/auth.dart';
import '../widgets/button.dart';

class Categorie extends StatefulWidget {

  Categorie({super.key});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  final CategorieCitationController categorieController =Get.put(CategorieCitationController());
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final AbonnementController abonnementController = Get.put(AbonnementController());
  bool isLoading = false;
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    isMounted = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await authenticateController.checkTokenExpiration(isMounted);
    });
    abonnementController.checkAbonnement();
    categorieController.getCategorieCitation();
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
        // iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.to(() => Base());
          },
        ),
        title: const Text(
          "Catégories",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<CategorieCitation>>(
                future: categorieController.getCategorieCitation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Echec de la connexion : ${snapshot.error}');
                  } else {
                    var categories = snapshot.data;
                    return GridView.builder(
                      itemCount: categories?.length,
                      gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20.0,
                      ),
                      itemBuilder: (context, index) {
                        var categorie = categories![index];
                        return CategorieCard(
                          name: categorie.name,
                          onTap: () async {
                            if (abonnementController.hasSubscription.value && abonnementController.expired.value) {
                              Get.offAll(Base(CategorieID: categorie.id));
                            }else{
                              showModalBottomSheet(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                              context: context,
                              builder: (BuildContext context) {
                                return const AbonnementPage();
                              },
                            );
                            }
                          },
                        );
                        
                      },
                    );
                  }
                },
              ),
            ),
            CButton(
              title: "Tout débloquer",
              onPressed: () {
                showModalBottomSheet(
                  // isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  context: context,
                  builder: (BuildContext context) {
                    return const AbonnementPage();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
