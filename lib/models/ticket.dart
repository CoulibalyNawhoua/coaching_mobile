class EventTicket {
  int id;
  String prixTickets;
  String referencesTickets;
  String libelle;
  String eventTitle;
  String eventImage;
  String dateEvenement;
  String heureEvenement;
  String adresseEvent;
  String? tauxReduction;
  String? quantiteTickets;

  EventTicket({
    required this.id,
    required this.prixTickets,
    required this.referencesTickets,
    required this.libelle,
    required this.eventTitle,
    required this.eventImage,
    required this.dateEvenement,
    required this.heureEvenement,
    required this.adresseEvent,
    this.tauxReduction,
    this.quantiteTickets,
  });

  factory EventTicket.fromJson(Map<String, dynamic> json) {
    return EventTicket(
      id: json['id'],
      prixTickets: json['prix_tickets'],
      referencesTickets: json['references_tickets'],
      libelle: json['libelle'],
      eventTitle: json['event_title'],
      eventImage: json['event_image'],
      dateEvenement: json['date_evenement'],
      heureEvenement: json['heure_evenement'],
      adresseEvent: json['adresse_event'],
      tauxReduction: json["taux_reduction"],
      quantiteTickets: json["quantite_tickets"],
    );
  }
}

class DetailsTicket {
  int id;
  String eventTitle;
  String eventImage;
  String dateEvenement;
  String heureEvenement;
  String adresseEvent;
  String referencesTickets;
  String prixTickets;
  String libelle;
  double tauxReduction;
  String quantiteTickets;
  int montantTotal;
  int montantPaye;

  DetailsTicket({
    required this.id,
    required this.eventTitle,
    required this.eventImage,
    required this.dateEvenement,
    required this.heureEvenement,
    required this.adresseEvent,
    required this.referencesTickets,
    required this.prixTickets,
    required this.libelle,
    required this.tauxReduction,
    required this.quantiteTickets,
    required this.montantTotal,
    required this.montantPaye,
  });

  factory DetailsTicket.fromJson(Map<String, dynamic> json) {
    return DetailsTicket(
      id: json["id"],
      eventTitle: json["event_title"],
      eventImage: json["event_image"],
      dateEvenement: json["date_evenement"],
      heureEvenement: json["heure_evenement"],
      adresseEvent: json["adresse_event"],
      referencesTickets: json["references_tickets"],
      prixTickets: json["prix_tickets"],
      libelle: json["libelle"],
      tauxReduction: json["taux_reduction"]?.toDouble(),
      quantiteTickets: json["quantite_tickets"],
      montantTotal: json["montant_total"],
      montantPaye: json["montants_paye"],
    );
  }
  
}
//pour ticket acheter
class TicketInfo {
  final String referencesTickets;
  final String prixTickets;
  final String titles;
  final String urlImages;
  final String dateEvenement;
  final String heureEvenement;
  final String adresseEvent;

  TicketInfo({
    required this.referencesTickets,
    required this.prixTickets,
    required this.titles,
    required this.urlImages,
    required this.dateEvenement,
    required this.heureEvenement,
    required this.adresseEvent,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) {
    return TicketInfo(
      referencesTickets: json['references_tickets'],
      prixTickets: json['prix_tickets'],
      titles: json['titles'],
      urlImages: json['url_images'],
      dateEvenement: json['date_evenement'],
      heureEvenement: json['heure_evenement'],
      adresseEvent: json['adresse_event'],
    );
  }
}

