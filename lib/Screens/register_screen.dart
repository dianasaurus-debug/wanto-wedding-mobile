import 'dart:convert';

import 'package:dream_wedding_app/Controllers/auth.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var email;
  var password;
  var nama_depan;
  var nama_belakang;
  var alamat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  "Daftar",
                                  style: TextStyle(color: Colors.white, fontSize: 40),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  "Welcome to Inside Android",
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
                                              validator: (namaDepanValue) {
                                                if (namaDepanValue!.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                nama_depan = namaDepanValue;
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "Masukkan nama depan",
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
                                              validator: (namaBelakangValue) {
                                                if (namaBelakangValue!.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                nama_belakang = namaBelakangValue;
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "Masukkan nama belakang",
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
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom:
                                                    BorderSide(color: Color(0xFFEEEEEE)))),
                                            child: TextFormField(
                                              maxLines: 3,
                                              validator: (alamatValue) {
                                                if (alamatValue!.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                alamat = alamatValue;
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "Masukkan alamat",
                                                  hintStyle: TextStyle(color: Colors.grey),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Sudah punya akun? ',
                                            style: TextStyle(
                                                color: Colors.grey)),
                                        TextSpan(
                                            text: 'Login',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold, color: Colors.grey,),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Route route = MaterialPageRoute(
                                                    builder: (context) => LoginScreen());
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
                                            _register();
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
                                              _isLoading? 'Proccessing...' : 'Daftar',
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
  void _register()
  async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password': password,
      'nama_depan': nama_depan,
      'nama_belakang': nama_belakang,
      'alamat' : alamat
    };

    var res = await AuthNetwork().authData(data, '/register');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['access_token']));
      localStorage.setString('user', json.encode(body['data']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => BottomNavigation()
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
