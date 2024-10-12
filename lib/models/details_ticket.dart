// class DetailsTicket {
//   int id;
//   String eventTitle;
//   String eventImage;
//   DateTime eventDate;
//   String eventHeure;
//   String eventAdresse;
//   int prixTickets;
//   String? referencesTicket;

//   DetailsTicket({
//     required this.id,
//    required this.eventTitle,
//    required this.eventImage,
//     required this.eventDate,
//     required this.eventHeure,
//     required this.eventAdresse,
//     required this.prixTickets,
//     this.referencesTicket,
//   });

//   factory DetailsTicket.fromJson(Map<String, dynamic> json) {
//     return DetailsTicket(
//       id: json['id'],
//       eventTitle: json['event_title'],
//       eventImage: json['event_image'],
//       eventDate: DateTime.parse(json['event_date']),
//       eventHeure: json['event_heure'],
//       eventAdresse: json['event_adresse'],
//       referencesTicket: json['ticket_reference'],
//       prixTickets: int.parse(json['ticket_price']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'event_title': eventTitle,
//       'event_image': eventImage,
//       'event_date': eventDate.toIso8601String(),
//       'event_heure': eventHeure,
//       'event_adresse': eventAdresse,
//       'ticket_reference': referencesTicket,
//       'ticket_price': prixTickets.toString(),
//     };
//   }
// }
