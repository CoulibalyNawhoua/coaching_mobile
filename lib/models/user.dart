class User {
  int id;
  String firstName;
  String lastName;
  String phone;
  String? email;
  String? urlPhoto;
  String? adresse;
  String? genre;
  String? status;
  String? addDate;
  String? editDate;
  dynamic editedBy;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.email,
    this.urlPhoto,
    this.adresse,
    this.genre,
     this.status,
     this.addDate,
    this.editDate,
    this.editedBy,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email'],
      urlPhoto: json['url_photo'],
      adresse: json['adresse'],
      genre: json['genre'],
      status: json['status'],
      addDate: json['add_date'],
      editDate: json['edit_date'],
      editedBy: json['edited_by'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "url_photo": urlPhoto,
    "adresse": adresse,
    "genre": genre,
    "status": status,
    "add_date": addDate,
    "edit_date": editDate,
    "edited_by": editedBy,
  };
}

class AbonnementInfo {
  AbonnementUser abonnement;
  List<AbonnementOffres> abonnementOffres;

  AbonnementInfo({
    required this.abonnement,
    required this.abonnementOffres,
  });

  factory AbonnementInfo.fromJson(Map<String, dynamic> json) {
    return AbonnementInfo(
      abonnement: AbonnementUser.fromJson(json['abonnement']),
      abonnementOffres: List<AbonnementOffres>.from(
        json['abonnement_offres'].map((x) => AbonnementOffres.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'abonnement': abonnement.toJson(),
    'abonnement_offres': abonnementOffres.map((offre) => offre.toJson()).toList(),
  };
  
}

class AbonnementUser {
  int id;
  String libelle;
  String prixAbonnements;
  String dureAbonnements;

  AbonnementUser({
    required this.id,
    required this.libelle,
    required this.prixAbonnements,
    required this.dureAbonnements,
  });

  factory AbonnementUser.fromJson(Map<String, dynamic> json) {
    return AbonnementUser(
      id: json['id'],
      libelle: json['libelle'],
      prixAbonnements: json['prix_abonnements'],
      dureAbonnements: json['periode'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'libelle': libelle,
    'prix_abonnements': prixAbonnements,
    'periode': dureAbonnements,
  };
}

class AbonnementOffres {
  String offres;

  AbonnementOffres({
    required this.offres,
  });

  factory AbonnementOffres.fromJson(Map<String, dynamic> json) {
    return AbonnementOffres(
      offres: json['offres'],
    );
  }
  Map<String, dynamic> toJson() => {
    'offres': offres,
  };
}
class UserResponse {
  User userInfo;
  String accessToken;
  String expiresAt;
  AbonnementInfo abonnementInfo;

  UserResponse({
    required this.userInfo,
    required this.accessToken,
    required this.expiresAt,
    required this.abonnementInfo,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    var abonnementInfoJson = json['abonnement_info'];
    AbonnementInfo abonnementInfo;

    if (abonnementInfoJson is List) {
      // Gérer le cas où abonnement_info est une liste vide
      abonnementInfo = AbonnementInfo(
        abonnement: AbonnementUser(id: 0, libelle: '', prixAbonnements: '', dureAbonnements: ''),
        abonnementOffres: [],
      );
    } else {
      // Gérer le cas où abonnement_info est un objet AbonnementInfo
      abonnementInfo = AbonnementInfo.fromJson(abonnementInfoJson);
    }

    return UserResponse(
      userInfo: User.fromJson(json['user_info']),
      accessToken: json['access_token'],
      expiresAt: json['expires_at'],
      abonnementInfo: abonnementInfo,
    );
  }


   Map<String, dynamic> toJson() => {
    'user_info': userInfo.toJson(),
    'access_token': accessToken,
    'expires_at': expiresAt,
    'abonnement_info': abonnementInfo.toJson(),
  };
}
