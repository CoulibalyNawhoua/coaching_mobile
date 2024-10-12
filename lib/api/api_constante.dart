class Api {
  static const url = 'https://coaching.distriforce.shop/api';
  static const imageUrl = 'https://coaching.distriforce.shop';
  // static const url = 'http://192.168.1.70/Coaching/coaching_web/public/api';
  // static const imageUrl = 'http://192.168.1.70/Coaching/coaching_web/public';

  static const register = '$url/inscription';
  static const login = '$url/signup';
  static const userInfos = '$url/user';
  static const CategorieCitation = '$url/categories/citations';
  static const Citations = '$url/citations';
  static const Evenements = '$url/evenements';
  static const AchatTickets = '$url/achats/ticket';
  static const Abonnement = '$url/abonnements';
  static const SouscriptionAbonnement = '$url/souscription';
  static const checkAbonnement = '$url/verifier-abonnement';
  static const getAccesUtilisateur = '$url/acces-utilisateur';
  static const getUserAbonnement = '$url/utilisateur-abonnement';
  static const verificationTicket = '$url/verifie/ticket';

  static String citationsCategorie(int categorieID) {
    return '$url/citations/categorie/$categorieID';
  }

  static String getDetailsEvenement(int EvenementID) {
    return '$url/details/evenements/$EvenementID';
  }

  static String getTicketEvent(int dateId) {
    return '$url/tickets/$dateId';
  }

  static String getDetailsTicket(String ticketId) {
    return '$url/ticket/$ticketId/event';
  }

  static String getDetailAbonnement(int abonId) {
    return '$url/abonnements/$abonId';
  }

  static String updateStatusPaiementAchat(int paiementId,int achatTicketId) {
    return '$url/paiements/$paiementId/$achatTicketId/update-status';
  }

  static String getTicket() {
    return '$url/details-ticket';
  }

  static String updateStatusPaiementAbon(int paiementId,int souscriptionId) {
    return '$url/paiementAbon/$paiementId/$souscriptionId/update-status';
  }

  static String updateUserProfile(int userId) {
    return '$url/user-profile-update/$userId';
  }
}


            