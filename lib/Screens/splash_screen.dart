import 'dart:async';
import 'dart:ui';

import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:dream_wedding_app/Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                "Wanto Wedding",
                style: TextStyle(
                  fontSize: 36,
                  color: Color(0xff80cbc4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Solusi kebutuhan wedding',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Spacer(flex: 2),
              Image.asset(
                'images/app_logo.jpg',
                height: 265,
              ),
              Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    backgroundColor: Color(0xff80cbc4),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavigation()),
                    )
                  },
                  child: Text(
                    "Lanjutkan",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
