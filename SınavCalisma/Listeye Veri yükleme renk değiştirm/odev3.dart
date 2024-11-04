import 'package:flutter/material.dart';

class RenkliListeApp extends StatefulWidget {
  const RenkliListeApp({Key? key}) : super(key: key);

  @override
  _RenkliListeAppDurumu createState() => _RenkliListeAppDurumu();
}

class _RenkliListeAppDurumu extends State<RenkliListeApp> {
  final TextEditingController _kelimeDenetleyici = TextEditingController();
  String? _secilenRenk;
  final List<String> _kelimeler = [];
  List<Color> _gridRenkleri = List.generate(6, (index) => Colors.grey);

  // Renk seçenekleri
  final Map<String, Color> _renkler = const {
    'Kırmızı': Colors.red,
    'Mavi': Colors.blue,
    'Yeşil': Colors.green,
    'Sarı': Colors.yellow,
    'Mor': Colors.purple,
  };

  void _kelimeVeRenkEkle() {
    String yeniKelime = _kelimeDenetleyici.text;

    if (yeniKelime.isNotEmpty && _secilenRenk != null) {
      setState(() {
        _kelimeler.add(yeniKelime);
        Color secilenRenk = _renkler[_secilenRenk]!;
        _gridRenkleri = List.generate(6, (index) => secilenRenk);
      });

      _kelimeDenetleyici.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Renkli Liste Uygulaması'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Kullanıcıdan veri alınan TextField
                Expanded(
                  child: TextField(
                    controller: _kelimeDenetleyici,
                    decoration: const InputDecoration(
                      labelText: 'Bir kelime girin',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Dropdown Menu
                DropdownButton<String>(
                  hint: const Text("Renk Seçin"),
                  value: _secilenRenk,
                  items: _renkler.keys.map((String renk) {
                    return DropdownMenuItem<String>(
                      value: renk,
                      child: Text(renk),
                    );
                  }).toList(),
                  onChanged: (String? yeniRenk) {
                    setState(() {
                      _secilenRenk = yeniRenk;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Kelimeyi listeye ekleyen buton
            ElevatedButton(
              onPressed: _kelimeVeRenkEkle,
              child: const Text('Kelimeyi Ekle ve Rengi Seç'),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  // Girilen kelimelerin listesi
                  Expanded(
                    child: ListView.builder(
                      itemCount: _kelimeler.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_kelimeler[index]),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Renkli grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: _gridRenkleri.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: _gridRenkleri[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
