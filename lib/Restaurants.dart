import 'package:qr_scanner/Drawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Restaurants extends StatelessWidget {
  String result;
  Restaurants({Key key, @required this.result}) : super(key: key);
  Future<List> getPost() async {
    //print('H2222:$barcode');
    var url = 'https://skip-the-queue.herokuapp.com/foodcourt/mallinfo';

    final header = {'Content-Type': 'application/json'};
    print('$result');
    var response = await post(url, headers: header, body: result);
    print('Response status: ${response.statusCode}');
    print(response.body.length);
    List jsonResponse = [];
    jsonResponse.clear();
    jsonResponse=json.decode(response.body); //Data in JSON
    print(jsonResponse.length);
    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurants'),
        ),
        drawer: MyDrawer(),
        body: Container(
          child: FutureBuilder(
            builder: (context, projectSnap) {
              if (!projectSnap.hasData) {
                //print('project snapshot data is: ${projectSnap.data}');
                return const Center(
                    child: CircularProgressIndicator());
              }
              else
              return ListView.builder(
                itemCount: projectSnap.data.length,
                itemBuilder: (context, index) {
                  var project = projectSnap.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Image.network(
                          project['photo'][0]['photo']['thumb_url'],
                          height: 100.0,
                          width: 100.0,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text('${project['name']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            )),
                      ],
                    ),
                  );
                },
              );

            },
            future: getPost(),
          ),
        ),
      ),
    );
  }
}
