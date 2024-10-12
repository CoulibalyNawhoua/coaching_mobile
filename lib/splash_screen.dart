import 'package:app_coaching/chargement.dart';
import 'package:flutter/material.dart';
import 'constantes/constantes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  ChargementPage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 200,
            ),
            const SizedBox(
              height: 30,
            ),
            LoadingText(),

            // const CircularProgressIndicator(
            //   color: Colors.white,
            // )
          ],
        ),
      ),
    );
  }
}

class LoadingText extends StatefulWidget {
  @override
  _LoadingTextState createState() => _LoadingTextState();
}


class _LoadingTextState extends State<LoadingText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Chargement',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        AnimatedBuilder(
          animation: AlwaysStoppedAnimation<int>(DateTime.now().millisecondsSinceEpoch),
          builder: (context, child) {
            final dotCount = (DateTime.now().millisecondsSinceEpoch ~/ 500) % 4;
            return Text(
              '.' * (dotCount + 1),
              style: TextStyle(color: Colors.white, fontSize: 18),
            );
          },
        ),
      ],
    );
  }
}

