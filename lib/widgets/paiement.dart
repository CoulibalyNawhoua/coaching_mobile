import 'package:app_coaching/constantes/constantes.dart';
import 'package:flutter/material.dart';

class PaiementCard extends StatelessWidget {
  const PaiementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 8,
          child: InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  bool isLoading = false;
                  bool isWaveCheked = false;
                  var montanyIntial = 5000;
                  var montantWave = 1000;
                  var fraisWave = (montantWave * 1.5 / 100).ceil();
                  var fraisEliah = (montanyIntial / 100).ceil();
                  var wave = montanyIntial + fraisWave + fraisEliah;

                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return FractionallySizedBox(
                        heightFactor: 1.1,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    const Center(
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/wave.png'),
                                        radius: 30,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "KOUAKOU albert",
                                        style:
                                            Theme.of(context).textTheme.titleLarge,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    // Text(
                                    //   "Motif : TITRE",
                                    //   style:
                                    //       Theme.of(context).textTheme.titleMedium,
                                    // ),
                                    // const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Montant à payer",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Text(
                                          "2000 FCFA",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //     height: size.height * 0.03),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Je décide de payer les frais",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Switch.adaptive(
                                          value: isWaveCheked,
                                          onChanged: (value) {
                                            setState(() {
                                              isWaveCheked = value;
                                              // Ajoutez ici votre logique de validation de l'opération
                                              if (isWaveCheked) {
                                                montantWave = wave;
                                              } else {
                                                montantWave = 1000;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Text(
                                          isWaveCheked ? "1000 FCFA" : "1000 FCFA",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              // bottom: size.height * 0.025,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 350),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Map data = {
                                        'montantInitial': montanyIntial,
                                        'montant': montantWave,
                                      };
                                      setState(() => isLoading = true);
                                      // Future.delayed(
                                      //   const Duration(seconds: 0),
                                      //   () => setState(() {
                                      //     paywave(data: data);
                                      //     // isLoading = false;
                                      //   }),
                                      // );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.secondaryColor,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: isLoading
                                        ? Container(
                                            width: 80,
                                            height: 40,
                                            padding: const EdgeInsets.all(2.0),
                                            child: const CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : const Text(
                                            "PASSER AU PAIEMENT",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            // -----------------------------------------------------------------------
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/wave.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_sharp,
                  // color: Colors.grey,
                  size: 20,
                ),
                // ignore: prefer_const_constructors
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Text(
                          'Wave',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        // Text('2.5%',
                        //     style: TextStyle(fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 10,),



      ],
    );
  }
}
