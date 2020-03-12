import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
    @override
    Widget build(BuildContext context) {


        return Drawer(

            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                    DrawerHeader(

                        decoration: BoxDecoration(
                            color: Colors.blue,
                            image:DecorationImage(
                                fit: BoxFit.fill,
                                image:  AssetImage('assets/images/drawer_header_background.png'))

                        ),
                        child: Text("SkipTheQ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500))
                                ),


                    ListTile(
                        leading: Icon(Icons.dashboard),
                        title: Text('Scan'),
                        onTap: () {
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Navigator.pushNamed(context,'/');
                        },
                    ),
                    ListTile(
                        leading: Icon(Icons.input),
                        title: Text('Restaurants'),
                        onTap: () {
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Navigator.pushNamed(context,'/rest');
                        },
                    ),


                ],
            ),
        );
    }
}

