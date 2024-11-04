import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text('Mobil Programlama Ödev 2'),
          centerTitle: true,
        ),
        body: NameWidget(),
      ),
    );
  }
}

// Stateful widget
class NameWidget extends StatefulWidget {
  @override
  _NameWidgetState createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  double _fontSize = 20.0;
  final List<String> _fontFamilies = [
    'Roboto',
    'Arial',
    'Courier',
    'Times',
    'Verdana'
  ];
  String _currentFontFamily = 'Roboto';

  void _changeFontRandomly() {
    setState(() {
      _currentFontFamily =
          _fontFamilies[Random().nextInt(_fontFamilies.length)];
    });
  }

  void _increaseFont() {
    setState(() {
      _fontSize += 1;
    });
  }

  void _decreaseFont() {
    setState(() {
      _fontSize -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Sinan Kerim Canan', // İsim ve soyisim
          style: TextStyle(fontSize: _fontSize, fontFamily: _currentFontFamily),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: _increaseFont, // Font büyüt
              child: Text('Font Büyüt'),
            ),
            ElevatedButton(
              onPressed: _decreaseFont, // Font küçült
              child: Text('Font Küçült'),
            ),
            ElevatedButton(
              onPressed: _changeFontRandomly, // Fontu rastgele değiştir
              child: Text('Rastgele Font'),
            ),
          ],
        ),
        SizedBox(height: 20), // Alt kısımda boşluk
      ],
    );
  }
}
