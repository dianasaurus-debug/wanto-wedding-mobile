
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  @override
  void initState() {
    // TODO: implement initState
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Text('Booking')
              )
            ],
          ),
        )
    );
  }
}
