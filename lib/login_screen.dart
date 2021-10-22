import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:dream_wedding_app/home_screen.dart';
import 'package:dream_wedding_app/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color : Color(0xff80cbc4)
        ),
        child: Column(
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
                      "Welcome to Inside Android",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
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
                              decoration: InputDecoration(
                                  hintText: "Enter your email",
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
                              decoration: InputDecoration(
                                  hintText: "Enter your password",
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
                            text: 'Belum punya akun? ',
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: 'Daftar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Route route = MaterialPageRoute(
                                    builder: (context) => RegisterScreen());
                                Navigator.push(context, route);
                              }),
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Lupa password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 15),
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
                          Route route = MaterialPageRoute(
                              builder: (context) => BottomNavigation());
                          Navigator.push(context, route);
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
                              "Login",
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
        ),
      ),
    );
  }
}
