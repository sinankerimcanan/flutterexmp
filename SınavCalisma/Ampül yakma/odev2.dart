import 'package:flutter/material.dart';
import 'dart:math';

class Lamba extends StatefulWidget {
  const Lamba({super.key});

  @override
  State<Lamba> createState() => _LambaState();
}

class _LambaState extends State<Lamba> {
  bool lambalarAcikMi = false;

  // Başlangıçta tüm lambalar kapalı (gri renkte)
  List<Color> lambaRenkleri = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  // Rastgele bir lamba yakma fonksiyonu
  void rastgeleLamba() {
    setState(() {
      lambalarAcikMi = true;
      int randomIndex = Random().nextInt(4);
      lambaRenkleri[randomIndex] = Colors.yellow;
    });
  }

  // Rastgele iki lamba yakma fonksiyonu
  void rastgeleIkiLambaYak() {
    setState(() {
      lambalarAcikMi = true;
      List<int> randomIndices = List.generate(4, (index) => index)..shuffle();
      lambaRenkleri[randomIndices[0]] = Colors.yellow;
      lambaRenkleri[randomIndices[1]] = Colors.yellow;
    });
  }

  // Tüm lambaları yakma fonksiyonu
  void tumLambalariYak() {
    setState(() {
      lambalarAcikMi = true;
      lambaRenkleri = List<Color>.filled(4, Colors.yellow);
    });
  }

  // Tüm lambaları söndürme fonksiyonu
  void tumLambalariSondur() {
    setState(() {
      lambalarAcikMi = false;
      lambaRenkleri = List<Color>.filled(4, Colors.grey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 1000,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 300,
                mainAxisSpacing: 650,
                // lambaRenkleri listesindeki renklere göre ikonları oluşturuyoruz
                children: List.generate(4, (index) {
                  return Icon(
                    Icons.lightbulb_circle_outlined,
                    size: 50,
                    color: lambaRenkleri[index],
                  );
                }),
              ),
              GestureDetector(
                onTap: () {
                  if (lambalarAcikMi) {
                    tumLambalariSondur();
                  } else {
                    rastgeleLamba();
                  }
                },
                onDoubleTap: () {
                  rastgeleIkiLambaYak();
                },
                onLongPress: () {
                  tumLambalariYak();
                },
                child: Text(
                  lambalarAcikMi ? 'Işıkları Kapat' : 'Işıkları Aç',
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
