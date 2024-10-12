import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/widgets/appBar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CappBar(title: "Notification"),
      body: listNotification(),
    );
  }
}

Widget listNotification(){
  return ListView.separated(itemBuilder: (context, index) {
    return listViewItem(index);
  }, 
  separatorBuilder: (context, index) {
    return Divider(height: 0,);
  }, 
  itemCount: 15);
}

Widget listViewItem(int index){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        prefixIcon(),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                messages(index),
                timeAndData(index)
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget prefixIcon(){
  return Container(
    height: 50,
    width: 50,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade300,
    ),
    child: Icon(
      Icons.notifications,
      color: AppColors.primaryColor,
      ),
  );
}


Widget messages(int index){
  return Container(
    child: RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan( 
        text: "message",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        children: [
          TextSpan(
            text: "notification description",
            style: TextStyle(
              fontWeight: FontWeight.w400,
            )
          )
        ]
      )
      ),
  );
}

Widget timeAndData(int index){
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "31-08-2023",
          style: TextStyle(
            fontSize: 10,
          ),
        ),
         Text(
          "09h30",
          style: TextStyle(
            fontSize: 10,
          ),
        )
      ],
    ),

  );
}