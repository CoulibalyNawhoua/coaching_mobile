import 'package:flutter/material.dart';


route(context, widget, {bool close = false}) => close
    ? Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => widget), (route) => false)
    : Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => widget),
      );
      
width(context) => MediaQuery.of(context).size.width;
height(context) => MediaQuery.of(context).size.height;


Route routeAnimation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page, 
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.decelerate;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}




// class EventPref {
//   static Future<UserInfo?> getUser() async {
//     UserInfo? user;
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String? stringUser = pref.getString('user_info');
//     if (stringUser != null) {
//       Map<String, dynamic> mapUser = jsonDecode(stringUser);
//       user = UserInfoInfoc.fromJson(mapUser);
//     }
//     if (kDebugMode) {
//       print(user);
//     }
//     return user;
//   }

//   static Future<void> saveUser(UserInfo user) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String stringUser = jsonEncode(user.toJson());
//     await pref.setString('user_info', stringUser);
//   }

//   static Future<void> deleteUser() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     await pref.remove('user_info');
//   }
// }

