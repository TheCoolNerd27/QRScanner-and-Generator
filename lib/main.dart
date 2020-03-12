
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'dart:convert' ;
import 'dart:io';
import 'package:qr_scanner/Drawer.dart';
import 'package:qr_scanner/Restaurants.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkiptheQ',
      //home: MyScan(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.

        // When navigating to the "/second" route, build the SecondScreen widget.

        '/': (context) => MyScan(),
        '/rest':(context) =>Restaurants(),

      },

    );
  }
}


class MyScan extends StatefulWidget {
  @override
  _MyScanState createState() => _MyScanState();
}

class _MyScanState extends State<MyScan> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);
  String Data;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Qrcode Scanner Example'),
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 25.0               ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.memory(bytes),
                ),
                SizedBox(
                  height: 15.0               ),
                Text('RESULT  $barcode'),

               TextField(
                 decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Data to be Coded',
                 ),
                 onSubmitted:(String value){
                   setState(() {
                     Data=value;
                   });


                 },
               ),
                RaisedButton(onPressed: _scan, child: Text("Scan"),
                color: Colors.blue,
                textColor: Colors.white,),
                RaisedButton(onPressed: (){
                  _scanPhoto();

                  },
                child: Text("Scan Photo")
                ,
                  color: Colors.orange,
                  textColor: Colors.black,),
                RaisedButton(onPressed: _generateBarCode, child: Text("Generate Barcode"),
                  color: Colors.red,
                  textColor: Colors.white,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan().then(
        (val)=>  Navigator.push(context, MaterialPageRoute(
          builder: (context) => Restaurants(result: val),
        ))

    );
    setState(() => this.barcode = barcode);
    //print('H:$barcode');

  }

  Future _scanPhoto() async {

    String barcode = await scanner.scanPhoto();
    setState(() => this.barcode = barcode);

  }

  Future _generateBarCode() async {
    Uint8List result = await scanner.generateBarCode(Data);
    this.setState(() => this.bytes = result);
  }

}

