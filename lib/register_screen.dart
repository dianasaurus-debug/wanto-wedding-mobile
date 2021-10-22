import 'package:dream_wedding_app/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
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
                child: Column(
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
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              hintText: "Nama Lengkap",
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
                                        child: TextField(
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              hintText: "E-Mail",
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
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              hintText: "Password",
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
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                              hintText: "Alamat",
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
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                    color: Color(0xff80cbc4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
          )

      );
  }
}
