class Abonnement {
  int id;
  String libelle;
  String prixAbonnements;
  String periode;

  Abonnement({
    required this.id,
    required this.libelle,
    required this.prixAbonnements,
    required this.periode,
  });

  factory Abonnement.fromJson(Map<String, dynamic> json) => Abonnement(
        id: json["id"],
        libelle: json["libelle"],
        prixAbonnements: json["prix_abonnements"],
        periode: json["periode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "prix_abonnements": prixAbonnements,
        "periode": periode,
      };
}

class Offre {
  String offres;

  Offre({
    required this.offres,
  });

  factory Offre.fromJson(Map<String, dynamic> json) => Offre(
        offres: json["offres"],
      );

  Map<String, dynamic> toJson() => {
        "offres": offres,
      };
}

class abonnementResponse {
  Abonnement abonnement;
  List<Offre> offres;

  abonnementResponse({
    required this.abonnement,
    required this.offres,
  });

  factory abonnementResponse.fromJson(Map<String, dynamic> json) =>
      abonnementResponse(
        abonnement: Abonnement.fromJson(json["abonnement"]),
        offres: List<Offre>.from(json["offres"].map((x) => Offre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "abonnement": abonnement.toJson(),
        "offres": List<dynamic>.from(offres.map((x) => x.toJson())),
      };
}
