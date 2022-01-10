import 'dart:convert';

import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:dream_wedding_app/Screens/home_screen.dart';
import 'package:dream_wedding_app/Screens/register_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var fcm_token;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late FirebaseMessaging messaging;

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      setState(() {
        fcm_token = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        child:Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color : Color(0xff80cbc4)
          ),
          child: Form(
              key: _formKey,
              child:  Column(
                mainAxisSize : MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Selamat datang di Wanto Wedding",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            )),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom:
                                              BorderSide(color: Color(0xFFEEEEEE)))),
                                      child: TextFormField(
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (emailValue) {
                                          if (emailValue!.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          email = emailValue;
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Masukkan akun E-Mail",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom:
                                              BorderSide(color: Color(0xFFEEEEEE)))),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (passwordValue) {
                                          if (passwordValue!.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          password = passwordValue;
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Masukkan kata sandi",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Belum punya akun? ',
                                      style: TextStyle(
                                          color: Colors.grey)),
                                  TextSpan(
                                      text: 'Daftar',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.grey,),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Route route = MaterialPageRoute(
                                              builder: (context) => RegisterScreen());
                                          Navigator.push(context, route);
                                        }),
                                ]),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      _login();
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: EdgeInsets.symmetric(horizontal: 50),
                                    decoration: BoxDecoration(
                                      color: Color(0xff80cbc4),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _isLoading? 'Proccessing...' : 'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ))
                ],
              )),
        ),

      ),

    );
  }
  void _login() async{
    print(fcm_token);
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password' : password,
      'fcm_token' : fcm_token
    };

    var res = await AuthNetwork().authData(data, '/login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['access_token'])); //Simpan token di local storage
      localStorage.setString('user', json.encode(body['data']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => BottomNavigation()
        ),
      );
    }else{
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal Login!",
        desc: "Pastikan E-Mail dan password benar.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
    setState(() {
      _isLoading = false;
    });

  }
}
