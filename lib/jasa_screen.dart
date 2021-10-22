
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class JasaScreen extends StatefulWidget {
  @override
  _JasaScreenState createState() => _JasaScreenState();
}

class _JasaScreenState extends State<JasaScreen> {

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
                  child: Text('Jasa')
              )
            ],
          ),
        )
    );
  }
}
