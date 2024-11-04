import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ButtonExample(),
    );
  }
}

class ButtonExample extends StatefulWidget {
  @override
  _ButtonExampleState createState() => _ButtonExampleState();
}

class _ButtonExampleState extends State<ButtonExample> {
  String buttonText = '';

  void handleButtonClick(String button) {
    setState(() {
      buttonText = "$button butonuna tıklandı";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buton Tıklama Örneği"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => handleButtonClick('A'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Buton arka plan rengi
                foregroundColor: Colors.white, // Yazı rengi
              ),
              child: Text('A Butonu'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleButtonClick('B'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Buton arka plan rengi
                foregroundColor: Colors.white, // Yazı rengi
              ),
              child: Text('B Butonu'),
            ),
            SizedBox(height: 40),
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.red, // Açıklama yazısı rengi
                fontSize: 35, // Punto boyutu
              ),
            ),
          ],
        ),
      ),
    );
  }
}
