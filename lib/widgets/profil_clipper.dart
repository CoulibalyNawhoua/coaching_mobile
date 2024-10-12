import 'package:app_coaching/constantes/constantes.dart';
import 'package:app_coaching/fonctions/fonction.dart';
import 'package:flutter/material.dart';


class ClipperCustom extends StatelessWidget {
  final name,phone,image;

  const ClipperCustom({
    required this.name,
    required this.phone,
    required this.image,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          ClipPath(
            clipper: clipperModule(),
            child: Container(
              color: AppColors.primaryColor,
              height: height(context) * 0.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: height(context)*0.01),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 5,),
                      // image: DecorationImage(
                      //   image: AssetImage(image),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                    child: ClipOval(
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/ai-generated-8083323_1280.jpg',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          );
                        },
                        
                      ),
                    ),
                    
                  ),
                  // Image.network(
                  //   // "${Api.imageUrl}/${detailsTicket.eventImage}",
                  //   image,
                  //   height: 100,
                  //   width: 100,
                  //   fit: BoxFit.cover,
                  // ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: width(context) *0.06,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    phone,
                    style: TextStyle(
                      color: Color(0xFF8492A2),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//  CustomClipper<Path>
class clipperModule extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}