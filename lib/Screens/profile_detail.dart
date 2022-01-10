import 'dart:async';
import 'dart:ui';

import 'package:dream_wedding_app/Controllers/user.dart';
import 'package:dream_wedding_app/Models/user.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:dream_wedding_app/Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  late Future<User> futureDetailUser;

  @override
  void initState() {
    super.initState();
    futureDetailUser = UserNetwork().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Detail Profil', style: TextStyle(color:Colors.black),),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
        ),
        body:
        FutureBuilder<User>(
          future: futureDetailUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                backgroundImage: snapshot.data!.profile_photo_path!=null ? NetworkImage(IMG_URL+snapshot.data!.profile_photo_path) : NetworkImage(IMG_URL+'user.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.green,
                                size: 40.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Lengkap', style: TextStyle(fontWeight : FontWeight.bold, fontSize: 16)),
                                    Text('${snapshot.data!.nama_depan} ${snapshot.data!.nama_belakang}', style: TextStyle(fontSize : 15))
                                  ]
                              )
                            ]
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.green,
                                size: 40.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('E-Mail', style: TextStyle(fontWeight : FontWeight.bold, fontSize: 16)),
                                    Text('${snapshot.data!.email}', style: TextStyle(fontSize : 15))
                                  ]
                              )
                            ]
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.green,
                                size: 40.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Alamat', style: TextStyle(fontWeight : FontWeight.bold, fontSize: 16)),
                                    Text('${snapshot.data!.alamat}', style: TextStyle(fontSize : 15))
                                  ]
                              )
                            ]
                        )
                      ],
                    ),
                  ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )

    );
  }
}
