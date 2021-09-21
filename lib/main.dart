import 'package:animation/3DCardAnimation/3d_card_home.dart';
import 'package:animation/CarAnimation/card_animation_home.dart';
import 'package:animation/pageview_anim.dart';
import 'package:animation/scale_anim.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text("Scale Anim"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScaleAnim()));
            },
          ),
          ListTile(
            title: Text("PageView Anim"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PageViewAnim()));
            },
          ),
          ListTile(
            title: Text("3D Card View"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DCardHome()));
            },
          ),
          ListTile(
            title: Text("Car Anim"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CarAnimHome()));
            },
          )
        ],
      ),
    );
  }
}
