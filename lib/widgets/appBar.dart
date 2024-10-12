import 'package:app_coaching/constantes/constantes.dart';
import 'package:flutter/material.dart';

class CappBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CappBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      title: Text(title),
      centerTitle: true,
      elevation: 0.0,
      // leading: SizedBox(),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: Icon(Icons.more_vert),
      //   ),
      // ],
    );
  }
}
