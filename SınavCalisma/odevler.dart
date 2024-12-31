import 'package:flutter/material.dart';
import 'dart:async'; // Asenkron işlemler için

class GirisEkrani extends StatelessWidget {
  final String kullaniciAdi = "volkan";
  final String sifre = "2003";
  final TextEditingController kullaniciAdiController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Ekranı')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: kullaniciAdiController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              controller: sifreController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (kullaniciAdiController.text == kullaniciAdi &&
                    sifreController.text == sifre) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TanitimEkrani()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Hata'),
                      content: Text('Bilgiler yanlış, tekrar deneyin.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Tamam'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}

class TanitimEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tanıtım Ekranı')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kelime Bulucu', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KelimeBulucuEkrani()),
              ),
              child: Text('Başlamak için Tıklayın'),
            ),
          ],
        ),
      ),
    );
  }
}

class KelimeBulucuEkrani extends StatefulWidget {
  @override
  _KelimeBulucuEkraniState createState() => _KelimeBulucuEkraniState();
}

class _KelimeBulucuEkraniState extends State<KelimeBulucuEkrani> {
  final TextEditingController harfController = TextEditingController();
  List<String> tumKelimeler = []; 
  List<String> bulunanKelimeler = [];

  @override
  void initState() {
    super.initState();
    _kelimeleriYukle(); 
  }

  Future<void> _kelimeleriYukle() async {
    try {
    
      String dosyaIcerigi =
          await DefaultAssetBundle.of(context).loadString('assets/words.txt');
      setState(() {
        tumKelimeler = dosyaIcerigi.split('\n'); 
      });
    } catch (e) {
      print("Dosya okunamadı: $e");
    }
  }

  void _kelimeBul(String harfler) {
    List<String> harfListesi = harfler.split('');
    setState(() {
      bulunanKelimeler = tumKelimeler
          .where((kelime) => _kelimeyiKontrolEt(kelime, List.from(harfListesi)))
          .toList();
    });
  }

 
  bool _kelimeyiKontrolEt(String kelime, List<String> harfler) {
    List<String> kelimeListesi = kelime.split('');

    for (String harf in kelimeListesi) {
      if (harfler.contains(harf)) {
        harfler.remove(harf); 
      } else {
        return false; 
      }
    }
    return true; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kelime Bulucu Ekranı')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: harfController,
              decoration: InputDecoration(labelText: 'Harfleri Girin'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String harfler = harfController.text;
                _kelimeBul(harfler); 
              },
              child: Text('Kelime Bul'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: bulunanKelimeler.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(bulunanKelimeler[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//GİRİS DART
import 'package:flutter/material.dart';
import 'package:odev4/giris_ekrani.dart';


void main() {
  runApp(KelimeBulucuApp());
}

class KelimeBulucuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelime Bulucu',
      home: GirisEkrani(), // Home olarak ⁠ GirisEkrani ⁠ tanımlandı.
    );
  }
}
//main
