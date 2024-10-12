class DetailsAbonnement {
  CategorieAbonnement categorieAbonnement;
  List<AbonnementOffre> abonnementOffre;

  DetailsAbonnement({
    required this.categorieAbonnement,
    required this.abonnementOffre,
  });

factory DetailsAbonnement.fromJson(Map<String, dynamic> json) =>
    DetailsAbonnement(
      categorieAbonnement: CategorieAbonnement.fromJson(json["categorie_abonnement"]),
      abonnementOffre: List<AbonnementOffre>.from(json["abonnement_offre"].map((x) => AbonnementOffre.fromJson(x))),
    );


  Map<String, dynamic> toJson() => {
    "categorie_abonnement": categorieAbonnement.toJson(),
    "abonnement_offre": List<dynamic>.from(abonnementOffre.map((x) => x.toJson())),
            
  };
}

class AbonnementOffre {
  String offres;

  AbonnementOffre({
    required this.offres,
  });

  factory AbonnementOffre.fromJson(Map<String, dynamic> json) =>
      AbonnementOffre(
        offres: json["offres"],
      );

  Map<String, dynamic> toJson() => {
        "offres": offres,
      };
}

class CategorieAbonnement {
  int id;
  String name;

  CategorieAbonnement({
    required this.id,
    required this.name,
  });

  factory CategorieAbonnement.fromJson(Map<String, dynamic> json) =>
      CategorieAbonnement(
        id: json["id"] as int,
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

