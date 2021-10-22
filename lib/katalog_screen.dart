
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class KatalogScreen extends StatefulWidget {
  @override
  _KatalogScreenState createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {

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
