import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);





  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("ANASAYFA"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Padding(padding: EdgeInsets.all(16)
          ),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddScreen()),
                  );

                });
              },
              child: Text("Ekle")
          ),
          SizedBox(height: 10,width: 1000),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ListScreen()),
                  );
                });
              },
              child: Text("LİSTELE")
          )
        ],
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////// EKLEME

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);
  State<AddScreen> createState()=> AddScreenState();
}

class AddScreenState extends State<AddScreen>{
  TextEditingController _controllertr = TextEditingController();
  TextEditingController _controllereng= TextEditingController();
  String tr="";
  String ing="";
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("EKLE"),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(

            controller: _controllertr,
            onChanged: (metin){
              setState(() {
                tr=metin;

              });
            },
            decoration: InputDecoration(
                labelText: "Türkçe Metin Giriniz",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                fillColor: Colors.deepPurple,
                filled: true,
                counterText: "Türkçe"
            ),
          ),
          SizedBox(height: 100,width: 100,),
          TextField(
            controller: _controllereng,
            onChanged: (metin){
              setState(() {
                ing=metin;

              });
            },
            decoration: InputDecoration(
                labelText: "İngilizce Metin Giriniz",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                fillColor: Colors.amber,
                filled: true,
                counterText: "İngilizce"
            ),
          ),
          SizedBox(height: 150,width: 150,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (){

                  },
                  child: Text("KAYDET")
              ),
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    });
                  },
                  child: Text("ANA SAYFA")
              ),
            ],
          )

        ],
      ),
    );
  }
}


/////////////////////////////////////////////////////////////////////////////////// LİSTELEME

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);
  State<ListScreen> createState()=> ListScreenState();
}

class ListScreenState extends State<ListScreen>{



  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("LİSTELE"),
      ),

      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder:(BuildContext context,  index){
                return ListTile(
                  title: Text("sa"),
                );
              },


            ),
          ),

          Expanded(
            child: ListView.builder(

              itemCount: 5,
              itemBuilder:(BuildContext context,  index){
                return ListTile(
                  title: Text("sa"),
                );
              },


            ),
          ),

          ElevatedButton(
            onPressed: (){
              setState(() {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              });
            },
            child: Text("ANASAYFA"),
          ),
        ],
      ),


    );


  }
}



