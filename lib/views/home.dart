
import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/controllers/CitationController.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/models/citation.dart';
import 'package:app_coaching/views/categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/auth.dart';

class HomePage extends StatefulWidget {
  final int? CategorieID;
  const HomePage({this.CategorieID, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CitationController citationCategorieController = Get.put(CitationController());
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
            onPressed: () {
              Get.to(Categorie());
              // Navigator.of(context).push(routeAnimation(Categorie()));
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            )),
        elevation: 0,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         route(context, NotificationPage());
        //       },
        //       icon: Icon(
        //         Icons.notifications,
        //         color: Colors.white,
        //       )),
        // ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/polynesia.jpg"),
              fit: BoxFit.cover,
            ),
          ),
            child: FutureBuilder<List<CitationModel>>(
                future: widget.CategorieID == null
                ? citationCategorieController.getCitation()
                : citationCategorieController.getCitationCategorie(widget.CategorieID!),
                builder: (context, snapshot) {
                  var citations = snapshot.data;
                  return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: citations?.length ?? 0,
                    itemBuilder: (context, index) {
                      var citation = citations![index];
                      return CitationItem(
                        content: citation.contenu,
                      );
                    },
                  );
                }),
         
        ),
      ),
    );
  }
}

class CitationItem extends StatelessWidget {
  
  final String content;
  const CitationItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.favorite_border,
              //     size: width(context) * 0.08,
              //     color: Colors.white,
              //   )
              // ),
              SizedBox(width: 20,),
              IconButton(
                  onPressed: () {
                    Share.share(content);
                  },
                icon: Icon(
                  Icons.share,
                  size: width(context) * 0.08,
                  color: Colors.white,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
