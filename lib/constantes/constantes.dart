import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF0D1331);
  static const Color secondaryColor = Color(0xFFCDB996);
  static const Color bodyBgColor = Color(0xFFf5f6fa);
}

const double defaultPadding = 16.0;

class Validator {
  static bool phone(String txt) {
    RegExp regExp = RegExp(r"^[0-9]{10}$");
    return regExp.hasMatch(txt);
  }

  static bool name(String txt) {
    return (txt.isNotEmpty); // en realité 3
  }

  static bool password(String txt) {
    return (txt.length >= 5);
  }
}
  String formatPrice(String montant) {
    final currencyFormatter = NumberFormat("#,##0 FCFA", "fr_FR");
    return currencyFormatter.format(double.parse(montant));
  }