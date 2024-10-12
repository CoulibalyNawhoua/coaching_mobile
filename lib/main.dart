import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'splash_screen.dart';

import 'package:flutter/widgets.dart';



// Future<void> main() async {
//   await SentryFlutter.init(
//     (options) {
//       options.dsn = 
//           'https://5e1cb0eb173598ff6d3e9625f5eb1273@o1147493.ingest.sentry.io/4506077117218816';
//       options.tracesSampleRate = 1.0;
//     },
//     appRunner: () => runApp(MyApp()),
//   );
//   await GetStorage.init();

//   try {
//     aMethodThatMightFail(); 
//   } catch (exception, stackTrace) {
//     await Sentry.captureException(
//       exception,
//       stackTrace: stackTrace,
//     );
//   }
// }

void aMethodThatMightFail() {
  throw Exception('Erreur !');
}

void main() async {
  await GetStorage.init();
  await initializeDateFormatting("fr_FR", null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: AppColors.secondaryColo),
      home: SplashScreen(),
    );
  }
}
