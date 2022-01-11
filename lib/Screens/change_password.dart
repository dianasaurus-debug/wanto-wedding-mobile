import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dream_wedding_app/Controllers/auth.dart';
import 'package:dream_wedding_app/Controllers/user.dart';
import 'package:dream_wedding_app/Models/user.dart';
import 'package:dream_wedding_app/Screens/profile_detail.dart';
import 'package:dream_wedding_app/Screens/setting_screen.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:dream_wedding_app/Screens/home_screen.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordUpdate extends StatefulWidget {
  @override
  _PasswordUpdateState createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  var password;
  var new_password;
  var alamat;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Edit Profil',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Masukkan password Lama',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green)),
                            hintStyle: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          obscureText: true,
                          validator: (passwordValue) {
                            if (passwordValue!.isEmpty) {
                              return 'Password lama tidak boleh kosong';
                            }
                            password = passwordValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Masukkan password Baru',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green)),
                            hintStyle: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          obscureText: true,
                          validator: (passwordValue) {
                            if (passwordValue!.isEmpty) {
                              return 'Password baru tidak boleh kosong';
                            }
                            new_password = passwordValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _updatePassword();
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
                                  _isLoading ? 'Proccessing...' : 'Update',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                      ],
                    )))));
  }

  void _updatePassword() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'password': password,
      'new_password': new_password,
      '_method': 'PUT'
    };

    var res = await AuthNetwork().postData(data, '/change/password');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => SettingScreen()),
      );
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal Update!",
        desc: "Pastikan password lama benar.",
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
