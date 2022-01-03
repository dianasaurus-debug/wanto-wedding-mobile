
import 'dart:convert';

import 'package:dream_wedding_app/Controllers/auth.dart';
import 'package:dream_wedding_app/Controllers/user.dart';
import 'package:dream_wedding_app/Models/user.dart';
import 'package:dream_wedding_app/Screens/change_profile.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/Screens/profile_detail.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() {
    return SettingScreenState();
  }
}

class SettingScreenState extends State<SettingScreen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Pengaturan', style: TextStyle(color : Colors.black),),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
        ),
        body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children : [
              GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileUpdate()),
                );
                },
                child:Card(
                  elevation: 2.0,
                  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(width: 1.0, color: Colors.white24))),
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                        title: Text(
                          "Update Profil",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                        trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.green, size: 30.0)),

                  ),
                )),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "myRoute");
                  },
                  child:Card(
                    elevation: 2.0,
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(width: 1.0, color: Colors.white24))),
                            child: Icon(Icons.password, color: Colors.black),
                          ),
                          title: Text(
                            "Ubah Password",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                          trailing:
                          Icon(Icons.keyboard_arrow_right, color: Colors.green, size: 30.0)),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "myRoute");
                  },
                  child:Card(
                    elevation: 2.0,
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(width: 1.0, color: Colors.white24))),
                            child: Icon(Icons.email, color: Colors.black),
                          ),
                          title: Text(
                            "Ubah E-Mail",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                          trailing:
                          Icon(Icons.keyboard_arrow_right, color: Colors.green, size: 30.0)),
                    ),
                  ))

            ]
          ),
        )

    );
  }
}
