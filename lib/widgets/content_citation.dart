import 'package:app_coaching/fonctions/fonction.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final String content;

  SlideItem({required this.content,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width(context) / 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: height(context) * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // IconButton(
                    //   onPressed: () {}, 
                    //   icon: Icon(
                    //     Icons.mic,
                    //     size: width(context) *0.08,
                    //     color: Colors.white,
                    //     )),
                    // IconButton(
                    //   onPressed: () {}, 
                    //   icon: Icon(
                    //     Icons.videocam,
                    //      size: width(context) *0.08,
                    //     color: Colors.white,
                    //     )),
                    IconButton(
                        onPressed: () {}, 
                        icon: Icon(
                          Icons.favorite_border,
                           size: width(context) *0.08,
                        color: Colors.white,
                          )),
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(
                        Icons.share,
                         size: width(context) *0.08,
                        color: Colors.white,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
