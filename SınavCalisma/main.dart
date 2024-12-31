import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maaş Yönetim Sistemi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text('Yeni Çalışan Ekleme'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.receipt),
                title: Text('Çalışan Maaş Bordrosu'),
                onTap: () {
                  // Maaş bordrosu görüntüleme işlevi
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Maaş Ödemeleri'),
                onTap: () {
                  // Maaş ödeme işlevi
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maaş Yönetim Sistemi'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showMenu(context),
          child: Text('Maaş Yönetimi Menüsü'),
        ),
      ),
    );
  }
}
// Yeni Çalışan Ekleme Ekranı
class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  String department = 'Departman Seç';
  double yearsOfWork = 0.0;
  XFile? image; // Seçilen fotoğraf için

  GoogleMapController? mapController; // Harita kontrolcüsü
  LatLng currentLocation = LatLng(37, 32); // Başlangıçta sıfır koordinat
  // Kullanıcının mevcut konumunu almak için fonksiyon
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servislerinin etkin olup olmadığını kontrol edin
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Konum servisleri etkin değilse, kullanıcıyı bilgilendirin
      return Future.error('Konum servisleri etkin değil.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // İzinler reddedildiyse, kullanıcıyı bilgilendirin
        return Future.error('Konum izinleri reddedildi.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // İzinler kalıcı olarak reddedildiyse, kullanıcıyı bilgilendirin
      return Future.error(
          'Konum izinleri kalıcı olarak reddedildi, ayarlardan izin verin.');
    }

    // Mevcut konumu alın
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Ekran yüklendiğinde konumu al
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form için bir anahtar
  // TC kimlik numarasının doğruluğunu kontrol eden fonksiyon
  String? validateID(String? value) {
    if (value == null || value.isEmpty || value.length != 11 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Geçerli bir TC kimlik numarası girin';
    }
    return null;
  }

  // Fotoğraf seçme işlevi
  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selected = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Çalışan Ekleme'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Fotoğraf Yükleme Alanı
                GestureDetector(
                  onTap: () => pickImage(),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: image != null
                        ? Image.file(File(image!.path))
                        : Icon(Icons.camera_alt, size: 50),
                  ),
                ),
                SizedBox(height: 20),
                // Ad Alanı
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Adı',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // TC Kimlik Numarası için TextFormField
                TextFormField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'TC Kimlik Numarası',
                    border: OutlineInputBorder(),
                  ),
                  validator: validateID, // Doğrulama fonksiyonunu burada kullanıyoruz
                ),
                SizedBox(height: 20),
                // Departman Seçimi
                DropdownButton<String>(
                  value: department,
                  onChanged: (String? newValue) {
                    setState(() {
                      department = newValue!;
                    });
                  },
                  items: <String>['Departman Seç', 'Muhasebe', 'IT', 'İnsan Kaynakları']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                // Maaş Alanı
                TextField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Maaşı',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Google Maps Harita
                Container(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: currentLocation, // Mevcut konumu kullanın
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Çalışma Yılı Slider'ı
                Slider(
                  value: yearsOfWork,
                  min: 0,
                  max: 50,
                  divisions: 50,
                  label: '${yearsOfWork.round()} Yıl',
                  onChanged: (double value) {
                    setState(() {
                      yearsOfWork = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                // Kaydet Butonu
                ElevatedButton(
                  onPressed: () {
                    // Kaydetme işlevi burada
                  },
                  child: Text('Kaydet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
