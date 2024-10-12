
class Evenement {
  final int id;
  final String titre;
  final String urlImage;
  final DateTime premiereDate;
  final DateTime derniereDate;
  final String heurePremiereDate;
  final String heureDerniereDate;

  Evenement({
    required this.id,
    required this.titre,
    required this.urlImage,
    required this.premiereDate,
    required this.derniereDate,
    required this.heurePremiereDate,
    required this.heureDerniereDate,
  });

  factory Evenement.fromJson(Map<String, dynamic> json) {
    
    return Evenement(
      id: json['id'],
      titre: json['titre'],
      urlImage: json['url_image'],
      premiereDate: DateTime.parse(json['premiere_date']),
      derniereDate: DateTime.parse(json['derniere_date']),
      heurePremiereDate: json['heure_premiere_date'],
      heureDerniereDate: json['heure_derniere_date'],
    );
  }
}

class EventDetails {
  int id;
  String titles;
  String descriptions;
  String urlImages;
  List<EventDate> datesEvenement;
  List<Ticket> tickets;

  EventDetails({
    required this.id,
    required this.titles,
    required this.descriptions,
    required this.urlImages,
    required this.datesEvenement,
    required this.tickets,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> datesList = json['dates_evenement'];
    List<EventDate> eventDates =
        datesList.map((date) => EventDate.fromJson(date)).toList();

    List<dynamic> ticketsList = json['tickets'];
    List<Ticket> eventTickets =
        ticketsList.map((ticket) => Ticket.fromJson(ticket)).toList();

    return EventDetails(
      id: json['id'],
      titles: json['titles'],
      descriptions: json['descriptions'],
      urlImages: json['url_images'],
      datesEvenement: eventDates,
      tickets: eventTickets,
    );
  }
}

class EventDate {
  int id;
  int idEvents;
  DateTime dateEvenement;
  String heureEvenement;
  String adresseEvent;
  DateTime addDate;

  EventDate({
    required this.id,
    required this.idEvents,
    required this.dateEvenement,
    required this.heureEvenement,
    required this.adresseEvent,
    required this.addDate,
  });

  factory EventDate.fromJson(Map<String, dynamic> json) {
    return EventDate(
      id: json['id'],
      idEvents: int.parse(json['id_events']),
      dateEvenement: DateTime.parse(json['date_evenement']),
      heureEvenement: json['heure_evenement'],
      adresseEvent: json['adresse_event'],
      addDate: DateTime.parse(json['add_date']),
    );
  }
}

class Ticket {
  int id;
  int idEvents;
  String addedBy;
  String addDate;
  String status;
  String quantiteTickets;
  String tauxReduction;

  Ticket({
    required this.id,
    required this.idEvents,
    required this.addedBy,
    required this.addDate,
    required this.status,
    required this.quantiteTickets,
    required this.tauxReduction,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      idEvents: int.parse(json['id_events']),
      addedBy: json['added_by'],
      addDate: json['add_date'],
      status: json['status'],
      quantiteTickets: json['quantite_tickets'],
      tauxReduction: json['taux_reduction'],
    );
  }
}

