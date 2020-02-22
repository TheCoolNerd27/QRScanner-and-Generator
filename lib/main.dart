
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart';
import 'dart:convert' ;
import 'dart:io';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    String barcode = await scanner.scan();
    setState(() => this.barcode = barcode);
    //print('H:$barcode');
   getPost();
  }

  Future _scanPhoto() async {

    String barcode = await scanner.scanPhoto();
    setState(() => this.barcode = barcode);

  }

  Future _generateBarCode() async {
    Uint8List result = await scanner.generateBarCode(Data);
    this.setState(() => this.bytes = result);
  }
  void getPost() async{
    //print('H2222:$barcode');
    var url = 'https://skip-the-queue.herokuapp.com/foodcourt/mallinfo';

    final header = {'Content-Type': 'application/json'};

    var response = await post(url,headers:header,body:barcode);
    print('Response status: ${response.statusCode}');

      var jsonResponse = json.decode(response.body);//Data in JSON

      print('Response body: ${response.body}');

  }
}