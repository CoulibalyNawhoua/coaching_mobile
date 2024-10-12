
class AchatTicket {
  String referencesAchats;
  String idInscriptions;
  String idTickets;
  String quantity;
  String montantsPaye;
  DateTime addDate;
  int id;

  AchatTicket({
    required this.referencesAchats,
    required this.idInscriptions,
    required this.idTickets,
    required this.quantity,
    required this.montantsPaye,
    required this.addDate,
    required this.id,
  });

  factory AchatTicket.fromJson(Map<String, dynamic> json) {
    return AchatTicket(
      referencesAchats: json['references_achats'],
      idInscriptions: json['id_inscriptions'],
      idTickets: json['id_tickets'],
      quantity: json['quantity'],
      montantsPaye: json['montants_paye'],
      addDate: DateTime.parse(json['add_date']),
      id: int.parse(json['id']),
    );
  }
  Map<String, dynamic> toJson() => {
        "references_achats": referencesAchats,
        "id_inscriptions": idInscriptions,
        "id_tickets": idTickets,
        "quantity": quantity,
        "montants_paye": montantsPaye,
        "id": id,
        "add_date": addDate.toIso8601String(),
      };
}
