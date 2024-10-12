import 'dart:io';

import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:app_coaching/views/modifier_password.dart';
import 'package:app_coaching/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api_constante.dart';
import '../controllers/UserController.dart';
import '../controllers/auth.dart';
import '../models/user.dart';
import '../widgets/dropdownState.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final UserController userController = Get.put(UserController());
  bool isMounted = false;
 late User user; 

  final first_nameController = TextEditingController();
  final last_nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final url_photoController = TextEditingController();
  final adresseController = TextEditingController();
  final genreController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final passwordConfirmeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isMounted = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await authenticateController.checkTokenExpiration(isMounted);
      loadUserInfo();
    });
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

    // Fonction pour charger les informations de l'utilisateur
  void loadUserInfo() async {
    // var userInfo = User.fromJson(GetStorage().read("user_info"));
    // inspect(userInfo);
    var userInfo = await userController.getUserInfo();
    setState(() {
      user = userInfo!;
      // user = userInfo!;
      // Préremplir les champs de saisie avec les valeurs actuelles de l'utilisateur
      first_nameController.text = user.firstName;
      last_nameController.text = user.lastName;
      emailController.text = user.email ?? "";
      adresseController.text = user.adresse ?? "";
      genreController.text = user.genre ?? "";
    
    });
  }

  // Fonction pour soumettre le formulaire
  void submitForm( int userId) async {

    if (_formKey.currentState!.validate()) {

      // _formKey.currentState!.save();
      String firstName = first_nameController.text;
      String lastName = last_nameController.text;
      String? email = emailController.text;
      String? adresse = adresseController.text;
      String? genre = genreController.text;
     // Vérifier si une nouvelle image a été sélectionnée
      String? imageUrl;
      if (pickedImage != null) {
        imageUrl = pickedImage!.path;
      }

      await userController.UpdateProfile(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        adresse: adresse,
        genre: genre,
        imageUrl: imageUrl,
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
         flexibleSpace: FlexibleSpaceBar(
          title: Text(
            "Mon Profil",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          ProfileDropdown(),
          // IconButton(
          //   onPressed: () {
          //     authenticateController.deconnectUser();
          //   },
          //   icon: const Icon(
          //     // Icons.logout,
          //     Icons.more_vert,
          //     color: Colors.white,
          //   )
          // ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder(
            future: userController.getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == null) {
                return Text('No data available');
              } else {
                final user = snapshot.data!;
                return Column(children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: clipperModule(),
                        child: Container(
                          color: AppColors.primaryColor,
                          height: height(context) * 0.2,
                        ),
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: height(context) * 0.02),
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                image: DecorationImage(
                                  image: pickedImage != null
                                    ? FileImage(pickedImage!) as ImageProvider
                                    : user.urlPhoto != null
                                        ? NetworkImage("${Api.imageUrl}${user.urlPhoto}")
                                        : AssetImage("assets/images/ai-generated-8083323_1280.jpg") as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (builder) => Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                                      ),
                                      child: bottomSheet(),
                                    ),
                                  );

                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2, color: Colors.white),
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: first_nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,size: 16,),
                            hintText: user.firstName,
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: last_nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,size: 16,),
                            hintText: user.lastName,
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail,size: 16,),
                            hintText: user.email != null ? user.email : "Entrez votre email",
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: adresseController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on,size: 16,),
                            hintText: user.adresse != null ? user.adresse : "Entrez votre adresse",
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: genreController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,size: 16,),
                            hintText: user.genre != null ? user.genre : "Entrez votre genre",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CButton(
                    title: "Mise à jour",
                    onPressed: () {
                      int userId = user.id;
                      submitForm(userId);
                    }
                  )
                ]);
              }
            }
        ),
      ),
    );
  }

  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: width(context),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Text(
            "choisir photo",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      selectPhoto(ImageSource.camera);
                    }, 
                    icon: Icon(Icons.camera),
                    
                  ),
                  Text("Camera",style: TextStyle(color: Colors.white),)
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      selectPhoto(ImageSource.gallery);
                    }, 
                    icon: Icon(Icons.image),
                    
                  ),
                  Text("Gallery",style: TextStyle(color: Colors.white),)
                ],
              )
            ],
          )
        ],
      ),
    );

  }

  File? pickedImage; // Variable pour stocker l'image choisie par l'utilisateur
  final ImagePicker picker = ImagePicker();
  Future<void> selectPhoto(ImageSource source) async {
    
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        // Mettre à jour l'URL de la photo avec la nouvelle photo choisie
        pickedImage = File(pickedFile.path);
        // userInfo.urlPhoto = pickedFile.path;
      });
      Navigator.pop(context);
    }else {
      print('Failed to pick image');
    }
  }

  //   Widget buildProfileDropdown(BuildContext context) {
  //   return DropdownButtonHideUnderline(
  //     child: DropdownButton<String>(
  //       icon: Icon(
  //         Icons.more_vert,
  //         color: Colors.white,
  //       ),
  //       items: [
  //         DropdownMenuItem(
  //           value: 'modifier_mdp',
  //           child: Text("Modifier le mot de passe"),
  //         ),
  //         DropdownMenuItem(
  //           value: 'deconnexion',
  //           child: Text("Déconnexion"),
  //         ),
  //       ],
  //       onChanged: (value) {
  //         if (value == 'modifier_mdp') {
  //           // Implement password change logic here
  //         } else if (value == 'deconnexion') {
  //           // Implement logout logic here
  //         }
  //       },
  //     ),
  //   );
  // }

}

//  CustomClipper<Path>
class clipperModule extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

